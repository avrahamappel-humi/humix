{
  description = "Local dev setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    php-8-1-9-pkgs.url = "nixpkgs/646edf48542caaf4ee418d03efc0f754b7adc409"; # for admin
  };

  outputs = { self, nixpkgs, flake-utils, php-8-1-9-pkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.permittedInsecurePackages = [ "nodejs-16.20.2" ];
        };

        humix = pkgs.callPackage ./humix.nix
          {
            projects = import ./projects.nix
              {
                inherit pkgs;
                php-8-1-9-pkgs = import php-8-1-9-pkgs { inherit system; };
              };
          };
      in
      {
        packages.default = humix.humix-setup;

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/humix-setup";
        };

        inherit (humix) devShells;
      });
}
