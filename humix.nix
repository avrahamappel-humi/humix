{ pkgs, lib, stdenv, writeShellScript, pathToHumility ? "~/humility" }:

let
  inherit (lib.strings) concatLines;
  inherit (lib.attrsets) mapAttrsToList;

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
    ln -s -f ${prepare-commit-message} ${dir}/.git/hooks/prepare-commit-msg
  '';

  # Set up dev shells
  setupNix = name: extraEnvrc: dir:
  let
    devShell = "${pathToHumility}/user_files/humix#${name}";
  in
  ''
    echo 'Installing Nix shell in ${dir}'
    echo 'use flake ${devShell}' > ${dir}/.envrc
  '' +
  concatLines (map (line: "echo ${line} >> ${dir}/.envrc") extraEnvrc);

  # Make a script linking files into a directory
  # This function takes two arguments:
  # `files` An attribute set of target paths mapped to source files (paths or drvs)
  # `dir`   A directory path to prepend to the target
  linkFiles = files: dir:
    concatLines (mapAttrsToList
      (target: source:
        "ln -s -f ${source} ${if dir == "" then "" else "${dir}/"}${target}")
      files);

  # Add ignored files to .git/info/exclude
  setupIgnoreFiles = files: dir: ''
    echo 'Adding ignored files to .git/info/exclude'
  '' +
  concatLines
    (map (file: "echo ${file} >> ${dir}/.git/info/exclude") files);

  # Run any additional setup
  runExtraScript = name: script: dir:
    let
      shellScript = writeShellScript "${name}-post-setup" script;
    in
    ''
      echo 'Running extra setup for ${name}'
      cd ${dir}
      direnv exec ${dir} ${shellScript}
    '';

  #########################################
  # Main project applications config list #
  #########################################
  projects =
    let
      phpactor = import ./phpactor.nix { inherit pkgs; };
    in
    {
      admin = {
        packages = with pkgs; [
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
          "app/rails.rb" = builtins.fetchurl {
            url = "https://gist.githubusercontent.com/castwide/28b349566a223dfb439a337aea29713e/raw/715473535f11cf3eeb9216d64d01feac2ea37ac0/rails.rb";
            sha256 = "0jv549plalb1d5jig79z6nxnlkg6mk0gy28bn4l8hwa6rlpl4j87";
          };
          ".solargraph.yml" = ./files/payroll/solargraph.yml;
          ".vimrc.lua" = ./files/payroll/vimrc.lua;
        };

        extraScript = ''
          # Bundle the project gems using Nix
          bundle config build.thin -fdeclspec
          bundle install
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
  # Runs extra script and sets up git hook
  # Adds .envrc and declared files to .git/info/exclude
  script = concatLines (mapAttrsToList
    (name:
      { packages ? [ ]
      , path ? "${pathToHumility}/applications/${name}"
      , extraEnvrc ? [ ]
      , files ? { }
      , extraScript ? null
      }: ''
        echo "Setting up project in ${path}"

        ${setupGithooks path}
        ${setupNix name extraEnvrc path}
        ${linkFiles files path}
        ${setupIgnoreFiles (builtins.attrNames files) path}

        direnv allow ${path}

        ${if (builtins.isString extraScript) then (runExtraScript name extraScript path) else ""}
      '')
    projects);

  humix-setup = writeShellScript "humix-setup" ''
    echo "Installing humix!"

    ${script}

    echo "Setup complete!"
  '';
in

{
  humix-setup =
    stdenv.mkDerivation {
      name = "humix";

      installPhase =
        let
          linkScripts = linkFiles
            {
              inherit humix-setup;
            } "$out/bin";
        in
        ''
          runHook preInstall
          mkdir -p $out/bin
          ${linkScripts}
          runHook postInstall
        '';

      dontUnpack = true;
    };

  devShells = builtins.mapAttrs
    (name: { packages, ... }: pkgs.mkShell {
      name = "${name}-dev-shell";
      buildInputs = packages;
    })
    projects;
}
