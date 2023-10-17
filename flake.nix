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
          ({ enabled, ... }:
            # ext-dom has failing tests in this particular build. Excluding ext-xmlreader as well which requires ext-dom
            builtins.filter (ext: ext.pname != "php-dom" && ext.pname != "php-xmlreader") enabled);

      # for ui
      node-18-18-1 =
        (import
          (pkgs.applyPatches {
            name = "nixpkgs-patched-nodejs.18.18.1";
            src = pkgs.path;
            patches = [
              (builtins.fetchurl {
                url = "https://github.com/NixOS/nixpkgs/commit/c8e2c3fb5841d09cf7f38374582b5eb20c22e440.patch";
                sha256 = "0fcz25yzyhgvr0j05ifxqwr98fa7rpjpk4ikm1w4z9w3cb70vm2i";
              })
            ];
          })
          { inherit system; }).nodejs_18;

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
          inherit pkgs php-8-1-9 node-18-18-1 ngserver;
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
