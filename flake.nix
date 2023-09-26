{
  description = "Local dev setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # for admin
    nixpkgs-php-8-1-9.url = "nixpkgs/646edf48542caaf4ee418d03efc0f754b7adc409";
    # for admin and hr
    nixpkgs-composer-2-6-3.url = "nixpkgs/c8b9e229e1242c9bd55fd45819fdf59b7cce2a78";
  };

  outputs = { self, nixpkgs, flake-utils, nixpkgs-php-8-1-9, nixpkgs-composer-2-6-3, ... }:
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
                pkgs-php-8-1-9 = import nixpkgs-php-8-1-9 { inherit system; };
                pkgs-composer-2-6-3 = import nixpkgs-composer-2-6-3 { inherit system; };
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
