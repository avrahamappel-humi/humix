{ pkgs, ngserver, writeText }:


#########################################
# Main project applications config list #
#########################################
let
  versionChecks = {
    php = "php --version | head -n 1 | awk '{ print $2; }'";
    node = "node --version";
    ruby = "ruby --version | awk '{ print $2; }'";
  };
in
{
  admin = {
    packages =
      let
        php = pkgs.php82;
      in
      [
        php
        php.packages.composer
        pkgs.phpactor
        pkgs.nodejs_16
        pkgs.nodePackages.vls
        pkgs.yarn
        pkgs.mysql
      ];

    files = {
      ".vimrc.lua" = writeText "vimrc.lua" ''
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

    extraEnvrc = [
      "layout php"
      "export DB_HOST=127.0.0.1"
      "export DB_PORT=33070"
      "export DB_HUMI_HOST=127.0.0.1"
      "export DB_HUMI_PORT=33060"
      "export REDIS_HOST=127.0.0.1"
    ];

    versionChecks = { inherit (versionChecks) php; };
  };

  hr = {
    packages =
      let
        php = pkgs.php82.withExtensions ({ enabled, all }: enabled ++ [ all.imagick ]);
      in
      [
        php
        php.packages.composer
        pkgs.phpactor
        pkgs.nodejs_20
        pkgs.yarn
        pkgs.mysql
      ];

    extraEnvrc = [
      "layout php"
      "export DB_HOST=127.0.0.1"
      "export DB_PORT=33060"
      "export REDIS_HOST=127.0.0.1"
    ];

    files = {
      ".vimrc.lua" = writeText "vimrc.lua" ''
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

    versionChecks = { inherit (versionChecks) php; };
  };

  payroll = {
    packages = [
      pkgs.postgresql
      pkgs.ruby_3_1
      pkgs.rubyPackages_3_1.solargraph
    ];

    extraEnvrc = [
      "layout ruby"
      # I don't get why this doesn't happen by default with `layout ruby`
      # See https://github.com/direnv/direnv/pull/883
      "path_add GEM_PATH \"$GEM_HOME\""
      # TODO formatting with rubocop still doesn't work
      # Also sometimes GEM_PATH is not set when opening the project with `txe`
    ];

    files = {
      ".solargraph.yml" = writeText "solargraph.yml" ''
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

      ".vimrc.lua" = writeText "vimrc.lua" ''
        registerLsps {
            lsps = { 'solargraph' }
        }
      '';
    };

    versionChecks = { inherit (versionChecks) ruby; };

    extraScript =
      let
        rails-rb = builtins.fetchurl {
          url = "https://gist.githubusercontent.com/castwide/28b349566a223dfb439a337aea29713e/raw/715473535f11cf3eeb9216d64d01feac2ea37ac0/rails.rb";
          sha256 = "0jv549plalb1d5jig79z6nxnlkg6mk0gy28bn4l8hwa6rlpl4j87";
        };
      in
      ''
        # Bundle the project gems using Nix
        bundle config build.thin -fdeclspec
        bundle install

        # Install solargraph rails file
        cp -f ${rails-rb} app/rails.rb
        echo app/rails.rb >> .git/info/exclude
      '';
  };

  ui = {
    packages = [
      pkgs.nodejs_20
      pkgs.yarn
      ngserver
    ];

    versionChecks = { inherit (versionChecks) node; };

    files.".vimrc.lua" = writeText "vimrc.lua" ''
      registerLsps {
          lsps = { 'angularls' },
          commands = {
              angularls = { 'ngserver', '--tsProbeLocations=.' },
          },
          root_dirs = {
              angularls = require("lspconfig").util.root_pattern("apps/hr-angular/project.json")
          }
      }
    '';

    extraEnvrc = [ "layout node" ];
  };
}
