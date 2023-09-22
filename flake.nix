{
  description = "Local dev setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.permittedInsecurePackages = [ "nodejs-16.20.2" ];
        };

        humix = pkgs.callPackage ./humix.nix {
          projects = import ./projects.nix { inherit pkgs; };
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
