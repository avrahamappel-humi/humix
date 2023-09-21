{ pkgs, lib, stdenv, writeShellScript, pathToHumility ? "~/humility", projects }:

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

  # Check versions of locally (direnv) installed packages with those installed in the container
  runVersionChecks = checks: messages-file: projectName: dir:
    let
      runChecks = concatLines (mapAttrsToList
        (pkgName: command: ''
          (
            local="$(direnv exec ${dir} ${command} 2> /dev/null)"
            container="$(docker compose exec -T ${projectName} ${command} 2> /dev/null)"

            if [[ "$local" != "$container" ]]; then
              {
                echo "VERSION MISMATCH: ${pkgName} in ${projectName}"
                echo "local:     $local"
                echo "container: $container"
              } >> "''$${messages-file}"
            fi
          ) &
        '')
        checks);
    in
    ''
      echo "Checking installed packages for mismatched versions"
      docker compose up ${projectName} -d
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
        echo "Setting up project in ${path}"

        ${setupGithooks path}
        ${setupNix name extraEnvrc path}

        direnv allow ${path}
        direnv exec ${path} echo 'Nix shell installed in ${name}'

        ${runVersionChecks versionChecks messages-file name path}

        ${linkFiles files path}
        ${setupIgnoreFiles (builtins.attrNames files) path}

        ${if (builtins.isString extraScript) then (runExtraScript name extraScript path) else ""}
      '')
    projects);

  humix-setup =
    let
      messages-file = "messages";
    in
    writeShellScript "humix-setup" ''
      echo "Installing humix!"

      # Version checks output
      ${messages-file}="$(mktemp)"

      ${script messages-file}

      # Print versions mismatches
      wait
      docker compose down --remove-orphans -t 1
      cat "''$${messages-file}"

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
