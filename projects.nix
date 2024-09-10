{ pkgs }:

{ ngserver, oldPkgs, stylelint-lsp }:

#########################################
# Main project applications config list #
#########################################

let
  inherit (pkgs.darwin.apple_sdk) frameworks;

  art = pkgs.writeShellScriptBin "art" ''
    php artisan "$@"
  '';

  tnk = pkgs.writeShellScriptBin "tnk" ''
    php artisan tinker "$@"
  '';

  bug = pkgs.writeShellScriptBin "bug" (builtins.readFile ./bug.sh);
in

{
  admin = {
    packages =
      let
        php = pkgs.php82.buildEnv {
          extensions = ({ enabled, all }: enabled ++ [ all.opentelemetry ]);
          extraConfig = ''
            memory_limit = -1
          '';
        };
      in
      [
        art
        php
        php.packages.composer
        pkgs.phpactor
        pkgs.nodejs_18
        pkgs.yarn
        pkgs.mysql
        tnk
      ];

    files = {
      ".phpactor.json" = /* json */ ''
        {
          "language_server_phpstan.enabled": true,
          "php_code_sniffer.enabled": true,
          "phpunit.enabled": true
        }
      '';

      "phpstan.neon" = ''
        includes:
          - vendor/nunomaduro/larastan/extension.neon
        parameters:
          paths:
          - app/
          # Level 9 is the highest level
          level: 5
      '';
    };

    extraEnvrc = [ "layout php" ];

    envVars = {
      DB_HOST = "127.0.0.1";
      DB_PORT = "33070";
      DB_HUMI_HOST = "127.0.0.1";
      DB_HUMI_PORT = "33060";
      REDIS_HOST = "127.0.0.1";
      DB_UI_HUMI = "mysql://root:root@127.0.0.1:33060/humi";
      DB_UI_ADMIN = "mysql://root:root@127.0.0.1:33070/admin";
      PAYROLL_API_URL = "http://127.0.0.1:3030/admin";
      MAIL_HOST = "127.0.0.1";
      LD_RELAY_REDIS_HOST = "127.0.0.1";
    };

    versionChecks = [ "php" "node" ];

    extraScript = ''
      echo "Setting PHPCodeSniffer config"
      phpcs --config-set default_standard PSR12,PHPCompatibility
      phpcs --config-set severity 1
      phpcs --config-set testVersion 8.2

      echo "Checking platform and installed extensions"
      composer check-platform-reqs
    '';
  };

  hr = {
    packages =
      let
        php = pkgs.php82.buildEnv {
          extensions = ({ enabled, all }: enabled ++ (with all; [ imagick xdebug ]));
          extraConfig = ''
            memory_limit = -1
            xdebug.mode=off
          '';
        };
      in
      [
        php
        php.packages.composer
        art
        bug
        pkgs.phpactor
        pkgs.nodejs_20
        pkgs.yarn
        pkgs.mysql
        tnk
      ];

    extraEnvrc = [ "layout php" ];

    envVars = {
      DB_HOST = "127.0.0.1";
      DB_PORT = "33060";
      REDIS_HOST = "127.0.0.1";
      DBUI_URL = "mysql://root:root@127.0.0.1:33060/humi";
      PAYROLL_API_URL = "http://127.0.0.1:3030/v2";
      MAIL_HOST = "127.0.0.1";
      LD_RELAY_REDIS_HOST = "127.0.0.1";
    };

    files = {
      ".phpactor.json" = /* json */ ''
        {
          "language_server_phpstan.enabled": true,
          "php_code_sniffer.enabled": true,
          "phpunit.enabled": true
        }
      '';

      "phpstan.neon" = ''
        parameters:
          paths:
          - app/
          # Level 9 is the highest level
          level: 5
      '';
    };

    versionChecks = [ "php" "node" ];

    extraScript = ''
      echo "Setting PHPCodeSniffer config"
      phpcs --config-set default_standard PSR12,PHPCompatibility
      phpcs --config-set severity 1
      phpcs --config-set testVersion 8.2

      echo "Checking platform and installed extensions"
      composer check-platform-reqs
    '';
  };

  payroll =
    let
      gh = "${pkgs.gh}/bin/gh";
      # Currently there's no way to get bndix to use git auth helpers
      # See https://github.com/nix-community/bundix/issues/69
      bundixWrapperContent = ''
        echo "Fetching Github credentials..."
        gh_user="$(${gh} auth status | head -n 2 | tail -n 1 | cut -d ' ' -f 9)"
        gh_token="$(${gh} auth token)"
        gh_auth="$gh_user:$gh_token@github.com"
        
        echo "Rewriting github.com urls to use $gh_auth..."
        sed "s/github.com/$gh_auth/g" Gemfile.lock > Gemfile.bundix.lock

        echo "Bundixing gems..."
        ${pkgs.bundix}/bin/bundix --lockfile Gemfile.bundix.lock
        rm Gemfile.bundix*
      '';
    in
    {
      useFlake = false;

      files = {
        ".solargraph.yml" = /* yaml */ ''
          include:
          - "**/*.rb"
          exclude:
          - spec/**/*
          - test/**/*
          - vendor/**/*
          - ".bundle/**/*"
          require: []
          domains: []
          reporters:
          - all!
          formatter:
            rubocop:
              cops: safe
              except: []
              only: []
              extra_args: []
          require_paths: []
          plugins: []
          max_files: 5000
        '';

        "shell.nix" = {
          copy = true;
          text = ''
            let
              pkgs = import ${oldPkgs.path} { };
              ruby = pkgs.ruby_3_1;
              env = pkgs.bundlerEnv {
                name = "payroll-env";
                inherit ruby;
                gemdir = ./.;
                gemConfig = pkgs.defaultGemConfig // {
                  rbnacl = with pkgs; attrs: {
                    dontBuild = false;
                    postPatch = '''
                      substituteInPlace lib/rbnacl/init.rb lib/rbnacl/sodium.rb \
                        --replace 'ffi_lib ["sodium"' \
                                  'ffi_lib ["''${libsodium}/lib/libsodium''${stdenv.hostPlatform.extensions.sharedLibrary}"'
                    ''';
                  };
                };
                ignoreCollisions = true;
                extraConfigPaths = [ "''${./.}/engines" ];
              };
              bundixWrapper = pkgs.writeShellScriptBin "bundix" '''${bundixWrapperContent}''';
            in

            pkgs.mkShell {
              # Ruby needs to be at the end so that `bundle` commands will use the `env` version
              packages = with pkgs; [ env bundixWrapper postgresql solargraph ruby ];

              DB_HOST = "127.0.0.1";
              REDIS_URL = "127.0.0.1";
              DBUI_URL = "postgres://postgres@127.0.0.1/ableAPI_development";
            }
          '';
        };

        # A shim for Solargraph to understand Rails code better
        "app/rails.rb" = {
          copy = true;
          text = builtins.fetchurl {
            url = "https://gist.githubusercontent.com/castwide/28b349566a223dfb439a337aea29713e/raw/715473535f11cf3eeb9216d64d01feac2ea37ac0/rails.rb";
            sha256 = "0jv549plalb1d5jig79z6nxnlkg6mk0gy28bn4l8hwa6rlpl4j87";
          };
        };
      };

      extraIgnores = [ "gemset.nix" ];

      extraEnvrc = [ "watch_file gemset.nix" ];

      beforeScript = pkgs.writeShellApplication {
        name = "payroll-env-setup";
        text = bundixWrapperContent;
      };

      versionChecks = [ "ruby" ];
    };

  ableScripts = {
    packages = [ bug pkgs.solargraph ];

    files = {
      ".solargraph.yml" = /* yaml */ ''
        include:
        - "**/*.rb"
        - "../payroll/app/**/*.rb"
        exclude:
        - spec/**/*
        - test/**/*
        - vendor/**/*
        - ".bundle/**/*"
        require: []
        domains: []
        reporters:
        - all!
        formatter:
          rubocop:
            cops: safe
            except: []
            only: []
            extra_args: []
        require_paths: []
        plugins: []
        max_files: 5000
      '';

      ".rubocop.yml" = /* yaml */ ''
        NumericLiterals:
          Enabled: false

        Style/StringLiterals:
          Description: Checks if uses of quotes match the configured preference.
          StyleGuide: https://github.com/bbatsov/ruby-style-guide#consistent-string-literals
          Enabled: true
          EnforcedStyle: double_quotes
          SupportedStyles:
            - single_quotes
            - double_quotes
      '';
    };
  };

  ui = {
    packages = [
      pkgs.nodejs_20
      pkgs.python311
      pkgs.yarn
      ngserver
      stylelint-lsp
      frameworks.CoreServices
    ];

    versionChecks = [ "node" ];

    files.".vimrc.lua" = /* lua */ ''
      registerLsps {
          lsps = { 'angularls', 'stylelint_lsp' },
          commands = {
              angularls = { 'ngserver', '--tsProbeLocations=.' },
              stylelint_lsp = { 'stylelint-lsp', '--stdio' },
          },
          root_dirs = {
              angularls = require("lspconfig").util.root_pattern("apps/hr-angular/project.json")
          }
      }
    '';

    extraEnvrc = [ "layout node" ];

    extraScript = ''
      # Need to run Yarn separately outside of the container
      yarn
    '';
  };
}
