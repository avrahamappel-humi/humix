{
  description = "Local dev setup";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.permittedInsecurePackages = [ "nodejs-16.20.2" ];
        };
      in
      {
        packages.default = pkgs.callPackage ./humix.nix { pathToHumility = builtins.toString ./../..; };

        apps.default = {
          program = "${self.packages.${system}.default}/bin/humix-setup";
        };
      });
}
