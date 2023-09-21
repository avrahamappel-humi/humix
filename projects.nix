{ pkgs }:


#########################################
# Main project applications config list #
#########################################
let
  phpactor = import ./phpactor.nix { inherit pkgs; };

  versionChecks = {
    php = "php --version | head -n 1 | awk '{ print $2; }'";
    composer = "composer --version | awk '{ print $3; }'";
    node = "node --version";
    ruby = "ruby --version | awk '{ print $2; }'";
  };
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

    versionChecks = { inherit (versionChecks) php composer node; };
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

    versionChecks = { inherit (versionChecks) php composer node; };
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
        cp ${rails-rb} app/rails.rb
        echo app/rails.rb >> .git/info/exclude
      '';
  };

  ui = {
    packages = [ pkgs.nodejs pkgs.yarn ];

    versionChecks = { inherit (versionChecks) node; };

    files.".vimrc.lua" = ./files/ui/vimrc.lua;

    extraEnvrc = [ "layout node" ];

    extraScript = ''
      echo "Installing ngserver"

      # Pinning this until we are on Angular 16
      npm install --no-save --force @angular/language-server@16.1.4
    '';
  };
}
