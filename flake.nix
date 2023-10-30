{
  description = "Local dev setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.permittedInsecurePackages = [ "nodejs-16.20.2" ];
      };

      # for admin
      php-8-1-9 =
        (import
          (pkgs.applyPatches {
            name = "nixpkgs-patched-php-8.1.9";
            src = pkgs.path;
            patches = [ ./php-8.1.9.patch ];
          })
          { inherit system; }).php81.withExtensions
          # ext-dom has failing tests in this particular build. Don't test it, and remove
          # it from ext-xmlreader's dependencies so it won't run the tests either
          ({ enabled, ... }: builtins.map
            (ext:
              if ext.pname == "php-dom" then ext.override { doCheck = false; } else
              if ext.pname == "php-xmlreader" then ext.override { internalDeps = [ ]; } else
              ext)
            enabled);

      # for angular templates
      # To update this, cd into ./ngserver and run
      # nix-shell -p node2nix --run node2nix
      # @angular/language-server is pinned at 16.1.4 until
      # humility is on typescript 5
      ngserver = (pkgs.callPackage ./ngserver {
        inherit pkgs system;
      }).nodeDependencies;

      humix = pkgs.callPackage ./humix.nix {
        projects = import ./projects.nix {
          inherit pkgs php-8-1-9 ngserver;
          inherit (pkgs) writeText;
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
