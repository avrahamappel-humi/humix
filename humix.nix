{ pkgs
, lib
, stdenv
, writeShellApplication
, writeShellScript
, writeText
, pathToHumility ? "~/humility"
, projects
}:

let
  inherit (lib.strings) concatLines;
  inherit (lib.attrsets) mapAttrsToList;

  # COLORS
  print = color: message: ''echo -e "\e[${color}m${message} \e[0m"'';
  colors = { red = "1;31"; yellow = "1;33"; green = "1;32"; cyan = "1;36"; };

  prepare-commit-message = writeShellScript "prepare-commit-message" ''
    # Checks if current branch matches JIRA pattern (ABC-1234-anything),
    # then adds ABC-1234 to start of commit message.
    # Originally written by @john-humi

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
  setupNix = { name, extraEnvrc, dir, useFlake }:
    let
      devShell = "${pathToHumility}/user_files/humix#${name}";
    in
    ''
      ${print colors.cyan "Installing Nix shell in ${dir}"}
      echo 'use flake ${devShell}' > ${dir}/.envrc
      ${if extraEnvrc != [] then ''
      cat >> ${dir}/.envrc << EOF
      ${concatLines extraEnvrc}
      EOF
      '' else ""}
    '';

  # Make a script linking files into a directory
  # This function takes two arguments:
  # `files` An attribute set of target paths mapped to source files (strings or drvs)
  # `dir`   A directory path to prepend to the target
  linkFiles = files: dir:
    concatLines (mapAttrsToList
      (target: file:
        let
          source = if builtins.isString file then writeText target file else file;
        in
        "ln -s -f ${source} ${if dir == "" then "" else "${dir}/"}${target}")
      files);

  # Add ignored files to .git/info/exclude
  setupIgnoreFiles = files: dir: ''
    ${print colors.cyan "Adding ignored files to .git/info/exclude"}
  '' +
  concatLines
    (map (file: "echo ${file} >> ${dir}/.git/info/exclude") files);

  # Run any additional setup
  runExtraScript = name: script: dir:
    let
      shellScript = writeShellApplication {
        name = "${name}-post-setup";
        text = script;
      };
    in
    ''
      ${print colors.cyan "Running extra setup for ${name}"}
      cd ${dir} || exit
      direnv exec ${dir} ${shellScript}
    '';

  # Check versions of locally (direnv) installed packages with those installed in the container
  runVersionChecks = checks: messages-file: projectName: dir:
    let
      runChecks = concatLines (mapAttrsToList
        (pkgName: command: ''
          (
            local="$(direnv exec ${dir} ${command})"
            container="$(docker compose exec -T ${projectName} ${command})"

            if [[ "$local" != "$container" ]]; then
              {
                ${print colors.red "VERSION MISMATCH: ${pkgName} in ${projectName}"}
                ${print colors.yellow  "local:     $local"}
                ${print colors.yellow  "container: $container"}
              } >> "''$${messages-file}"
            fi
          ) &
        '')
        checks);
    in
    ''
      ${print colors.cyan "Checking installed packages for mismatched versions"}
      docker compose up ${projectName} -d 2> /dev/null
      ${runChecks}
    '';

  # Script that builds drv for each application and appends it to use nix in envrc
  # Writes any declared files and creates symlinks for them
  # Runs extra script and sets up git hook
  # Adds .envrc and declared files to .git/info/exclude
  script = messages-file: concatLines (mapAttrsToList
    (name:
      { packages ? [ ]
      , path ? "${pathToHumility}/applications/${name}"
      , extraEnvrc ? [ ]
      , files ? { }
      , extraScript ? null
      , versionChecks ? { }
      }: ''
        ${print colors.green "Setting up project in ${path}"}

        ${setupGithooks path}
        ${setupNix { inherit name extraEnvrc useFlake; dir = path; }}

        direnv allow ${path}
        direnv exec ${path} ${print colors.green "Nix shell installed in ${name}"}

        ${runVersionChecks versionChecks messages-file name path}

        ${linkFiles files path}
        ${setupIgnoreFiles (builtins.attrNames files) path}

        ${if builtins.isString extraScript then runExtraScript name extraScript path else ""}
      '')
    projects);

  humix-setup =
    let
      messages-file = "messages";
    in
    writeShellApplication {
      name = "humix-setup";
      text = ''
        # Sometimes docker messes up the display
        reset

        ${print colors.green "Installing humix!"}

        # Version checks output
        ${messages-file}="$(mktemp)"

        ${script messages-file}

        # Print versions mismatches
        ${print colors.cyan "Fetching messages"}
        wait
        docker compose down --remove-orphans -t 1 2> /dev/null
        cat "''$${messages-file}"

        ${print colors.green "Setup complete!"}
      '';
    };
in

{
  inherit humix-setup;

  devShells = builtins.mapAttrs
    (name: { packages, ... }: pkgs.mkShell {
      name = "${name}-dev-shell";
      inherit packages;
    })
    projects;
}
