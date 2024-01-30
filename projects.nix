{ pkgs, ngserver, stylelint-lsp }:

let
  inherit (pkgs.darwin.apple_sdk) frameworks;
in

#########################################
# Main project applications config list #
#########################################
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
      ".solargraph.yml" = ''
        ---
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

      ".vimrc.lua" = /* lua */ ''
        registerLsps {
            lsps = { 'solargraph' }
        }
      '';

      "shell.nix" = {
        copy = true;
        text = /* nix */ ''
          let
            pkgs = import ${pkgs.path} { };
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
                # nokogiri is currently blocked from compiling on nixos unstable [d870193](https://github.com/NixOS/nixpkgs/pull/274550/commits/d870193b2d99dc2744cee8111468135e4c83bde2) and above
                # due to changes in libxml2 which cause compiler errors. If our dependency is not updated soon, we'll have to disable the compiler error
                # This is solved in Nokogiri v1.16.0.rc1 and above. See https://github.com/sparklemotion/nokogiri/issues/3071
              };
              ignoreCollisions = true;
              extraConfigPaths = [ "''${./.}/engines" ];
            };
          in

          pkgs.mkShell {
            packages = [
              ruby
              env
              pkgs.rubyPackages_3_1.solargraph
              pkgs.bundix
              pkgs.postgresql
            ];

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
