{ pkgs }:

{ ngserver, oldPkgs, stylelint-lsp }:

#########################################
# Main project applications config list #
#########################################

let
  inherit (pkgs.darwin.apple_sdk) frameworks;

  xdebugClient = pkgs.stdenv.mkDerivation {
    name = "xdebug-client-macos-arm64";
    src = pkgs.fetchurl {
      url = "https://xdebug.org/files/binaries/dbgpClient-macos-arm64";
      hash = "sha256-Yk1BsJB7nASuNsQ0Klh+4+dBNnO2FawOgLkomzMNuUM=";
      executable = true;
    };
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      install $src $out/bin/xdebug
      runHook postInstall
    '';
  };

  artisan = php: pkgs.writeShellScriptBin "art" ''
    ${php}/bin/php artisan "$@"
  '';

  bug = pkgs.writeShellScriptBin "bug" (builtins.readFile ./bug.sh);
in

{
  admin = {
    packages =
      let
        php = pkgs.php82.buildEnv {
          extraConfig = ''
            memory_limit = -1
          '';
        };
      in
      [
        php
        php.packages.composer
        (artisan php)
        pkgs.phpactor
        pkgs.nodejs_18
        pkgs.nodePackages.vls
        pkgs.yarn
        pkgs.mysql
      ];

    files = {
      ".vimrc.lua" = /* lua */ ''
        registerLsps {
            lsps = { 'phpactor', 'vuels' },
            settings = {
                phpactor = {
                    language_server_phpstan = {
                        enabled = true,
                        level = 5,
                    },
                    phpunit = {
                        enabled = true,
                    },
                },
                vetur = {
                    ignoreProjectWarning = true
                },
            }
        }
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
    };

    versionChecks = [ "php" "node" ];
  };

  hr = {
    packages =
      let
        php = pkgs.php82.buildEnv {
          extensions = ({ enabled, all }: enabled ++ [ all.imagick ]);
          extraConfig = ''
            memory_limit = -1
          '';
        };
      in
      [
        php
        php.packages.composer
        xdebugClient
        (artisan php)
        bug
        pkgs.phpactor
        pkgs.nodejs_20
        pkgs.yarn
        pkgs.mysql
      ];

    extraEnvrc = [ "layout php" ];

    envVars = {
      DB_HOST = "127.0.0.1";
      DB_PORT = "33060";
      REDIS_HOST = "127.0.0.1";
      DBUI_URL = "mysql://root:root@127.0.0.1:33060/humi";
    };

    files = {
      ".vimrc.lua" = /* lua */ ''
        registerLsps {
            lsps = { 'phpactor' },
            settings = {
                phpactor = {
                    phpunit = {
                        enabled = true,
                    },
                },
            }
        }
      '';
    };

    versionChecks = [ "php" "node" ];
  };

  payroll = {
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
        text = /* nix */ ''
          let
            pkgs = import ${oldPkgs.path} { };
            ruby = pkgs.ruby_3_1;
            env = pkgs.bundlerEnv {
              name = "payroll-env";
              inherit ruby;
              gemdir = ./.;
              gemConfig = pkgs.defaultGemConfig // {
                nio4r = attrs: {
                  dontBuild = false; # It doesn't apply the patch without this
                  patches = [ ${./patches/nio4r-fix-clang-16.patch} ];
                };
                rbtree = attrs: {
                  dontBuild = false;
                  patches = [ ${./patches/rbtree-fix-clang-16.patch} ];
                };
              };
              ignoreCollisions = true;
              extraConfigPaths = [ "''${./.}/engines" ];
            };
          in

          pkgs.mkShell {
            packages = with pkgs; [ ruby env bundix postgresql solargraph ];

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

    beforeScript = pkgs.writeShellApplication {
      name = "payroll-env-setup";

      runtimeInputs = [ pkgs.bundix ];
      text = ''
        echo "Bundixing gems..."
        bundix
      '';
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
