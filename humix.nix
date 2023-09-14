{ pkgs, lib, stdenv, pathToHumility ? "~/humility" }:

let
  inherit (builtins) attrNames attrValues isFile mapAttrs pathExists;
  inherit (pkgs) writeFile writeShellScript;
  inherit (lib.strings) concatLines;

  prepare-commit-message = writeShellScript "prepare-commit-message" ''
    # Checks if current branch matches JIRA pattern (ABC-1234-anything),
    # then adds ABC-1234 to start of commit message.

    BRANCH_NAME=$(git branch 2>/dev/null | grep -e ^* | tr -d ' *')

    REGEX='^([a-zA-Z]{2,4}-[0-9]+)-*'

    if [ -n "$BRANCH_NAME" ]; then
        [[ $BRANCH_NAME =~ $REGEX ]]

        if [ -n "$BASH_REMATCH" ]; then
            echo "''${BASH_REMATCH[1]} $(cat $1)" > $1
        fi
    fi
  '';

  # Set up git hooks (currently only one)
  setupGithooks = dir: ''
    ln -s -f "${prepare-commit-message}" "${dir}/.git/hooks/prepare-commit-msg"
  '';

  # Set up dev shells
  setupNix = devShell: extraEnvrc: dir: ''
    echo 'Installing Nix shell in ${dir}'
    echo 'use nix -p ${devShell}' > ${dir}/.envrc
  '' +
  concatLines (map (line: "echo ${line} >> ${dir}/.envrc") extraEnvrc);

  # Link additional files to the root of the application
  linkExtraFiles = files: dir:
    concatLines
      (attrValues
        (mapAttrs
          (path: contents:
            let
              file = writeFile (if pathExists contents then import contents else contents); in
            "ln -s -f ${file} ${dir}/${path}")
          files));

  # Add ignored files to .git/info/exclude
  setupIgnoreFiles = files: dir:
    "echo 'Adding ignored files to .git/info/exclude'"
      concatLines
      (map (file: "echo ${file} >> ${dir}/.git/info/exclude") files);

  #########################################
  # Main project applications config list #
  #########################################
  projects =
    let
      phpactor = import ./phpactor.nix { inherit pkgs; };
    in
    {
      admin = {
        packages =
          let
            pkgs' = pkgs.overrideConfig {
              permittedInsecurePackages = [ "nodejs-16.20.2" ];
            };
          in
          with pkgs'; [
            php81
            php81Packages.composer
            php81Packages.psalm
            phpactor
            nodejs-16_x
            nodePackages.vls
            yarn
          ];

        extraEnvrc = [ "layout php" ];

        files = {
          ".vimrc.lua" = ./files/admin/vimrc.lua;
          "psalm.xml" = ./files/admin/psalm.xml;
        };
      };

      hr = {
        packages =
          let
            php = pkgs.php81.withExtensions ({ enabled, all }: enabled ++ [ all.imagick ]);
          in
          [
            php
            php.packages.composer
            phpactor
            pkgs.nodejs_20
            pkgs.yarn
          ];

        extraEnvrc = [ "layout php" ];

        files = {
          ".vimrc.lua" = ./files/hr/vimrc.lua;
          "psalm.xml" = ./files/hr/psalm.xml;
        };
      };

      payroll = {
        packages = [
          pkgs.postgresql
          pkgs.ruby_3_1
          pkgs.rubyPackages_3_1.solargraph
        ];

        extraEnvrc = [ "layout ruby" ];

        files = {
          "app/rails.rb" = https://gist.githubusercontent.com/castwide/28b349566a223dfb439a337aea29713e/raw/715473535f11cf3eeb9216d64d01feac2ea37ac0/rails.rb;
          ".solargraph.yml" = ./files/payroll/solargraph.yml;
          ".vimrc.lua" = ./files/payroll/vimrc.lua;
        };

        extraScript = ''
          # Bundle the project gems using Nix
          bundle config build.thin -fdeclspec
          bundle install

          # Set up solargraph
          solargraph download-core
          solargraph bundle
        '';
      };

      ui = {
        packages = [ pkgs.nodejs pkgs.yarn ];

        files.".vimrc.lua" = ./files/ui/vimrc.lua;

        extraEnvrc = [ "layout node" ];

        extraScript = ''
          echo "Installing ngserver"

          # Pinning this until we are on Angular 16
          npm install --no-save @angular/language-server@16.1.4
        '';
      };
    };

  # Script that builds drv for each application and appends it to use nix in envrc
  # Writes any declared files and creates symlinks for them
  # Adds .envrc and declared files to .git/info/exclude
  # Runs extra script
  # Sets up git hook
  script = concatLines (attrValues (mapAttrs
    (name:
      { packages ? [ ]
      , path ? "${pathToHumility}/applications/${name}"
      , extraEnvrc ? [ ]
      , files ? { }
      , extraScript ? null
      }:
      let
        devShell = pkgs.mkShell { buildInputs = packages; };
      in
      ''
        echo "Setting up project in ${path}"

        ${setupGithooks path}
        ${setupNix devShell extraEnvrc path}
        ${linkExtraFiles files path}
        ${setupIgnoreFiles (attrNames files) path}
        direnv allow ${path}

        ${if (isFile extraScript) then "cd ${path}; direnv exec ${path} ${extraScript}" else ""}
      '')
    projects));

  humix-setup = writeShellScript "humix-setup" ''
    echo "Installing humix!"

    ${script}

    echo "Setup complete!"
  '';
in

stdenv.mkDerivation {
  name = "humix";

  buildInputs = [
    humix-setup
  ];
}
