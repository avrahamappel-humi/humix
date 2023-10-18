{ pkgs
, php-8-1-9
, node-18-18-1
, ngserver
}:


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
    packages = [
      php-8-1-9
      php-8-1-9.packages.composer
      pkgs.phpPackages.psalm
      pkgs.phpactor
      pkgs.nodejs_16
      pkgs.nodePackages.vls
      pkgs.yarn
      pkgs.mysql
    ];

    files = {
      ".vimrc.lua" = ./files/admin/vimrc.lua;
      "psalm.xml" = ./files/admin/psalm.xml;
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
        php = pkgs.php81.withExtensions ({ enabled, all }: enabled ++ [ all.imagick ]);
      in
      [
        php
        php.packages.composer
        pkgs.phpactor
        pkgs.phpPackages.psalm
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
      ".vimrc.lua" = ./files/hr/vimrc.lua;
      "psalm.xml" = ./files/hr/psalm.xml;
    };

    versionChecks = { inherit (versionChecks) php; };
  };

  payroll = {
    packages = [
      pkgs.postgresql
      pkgs.ruby_3_1
      pkgs.rubyPackages_3_1.solargraph
    ];

    extraEnvrc = [ "layout ruby" ];

    files = {
      ".solargraph.yml" = ./files/payroll/solargraph.yml;
      ".vimrc.lua" = ./files/payroll/vimrc.lua;
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
      node-18-18-1
      pkgs.yarn
      ngserver
    ];

    versionChecks = { inherit (versionChecks) node; };

    files.".vimrc.lua" = ./files/ui/vimrc.lua;

    extraEnvrc = [ "layout node" ];
  };
}
