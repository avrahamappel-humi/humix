{
  description = "Local dev setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-php-8-1-9.url = "nixpkgs/646edf48542caaf4ee418d03efc0f754b7adc409";
    nixpkgs-composer-2-6-3.url = "nixpkgs/c8b9e229e1242c9bd55fd45819fdf59b7cce2a78";
    nixpkgs-node-20-5-1.url = "nixpkgs/540a97984288db83d642812565fb43f276b02f21";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , nixpkgs-php-8-1-9
    , nixpkgs-composer-2-6-3
    , nixpkgs-node-20-5-1
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.permittedInsecurePackages = [ "nodejs-16.20.2" ];
      };

      # for admin
      php-8-1-9 = (import nixpkgs-php-8-1-9 { inherit system; }).php81;

      # for admin and hr
      composer-2-6-3 =
        (import nixpkgs-composer-2-6-3 { inherit system; }).phpPackages.composer;

      # for hr
      node-20-5-1 = (import nixpkgs-node-20-5-1 { inherit system; }).nodejs_20;

      # for ui
      node-18-18-0 =
        let
          nodeTools = "${nixpkgs}/pkgs/development/web/nodejs";
        in
        (pkgs.callPackage "${nodeTools}/nodejs.nix" { python = pkgs.python3; }) {
          enableNpm = false;
          version = "18.18.0";
          sha256 = "140gzrf9zm9dzfaqlbjq771r717rg3d4gnq05y4rzn9l6sndpm74";
          patches = [
            "${nodeTools}/disable-darwin-v8-system-instrumentation.patch"
            "${nodeTools}/bypass-darwin-xcrun-node16.patch"
            "${nodeTools}/revert-arm64-pointer-auth.patch"
            "${nodeTools}/node-npm-build-npm-package-logic.patch"
            "${nodeTools}/trap-handler-backport.patch"
          ];
        };

      # for angular templates
      # To update this, cd into ./ngserver and run
      # nix-shell -p node2nix --run node2nix
      # @angular/language-server is pinned at 16.1.4 until
      # humility is on typescript 5
      ngserver = (pkgs.callPackage ./ngserver { inherit pkgs system; }).nodeDependencies;

      humix = pkgs.callPackage ./humix.nix {
        projects = import ./projects.nix {
          inherit pkgs php-8-1-9 composer-2-6-3 node-20-5-1 node-18-18-0 ngserver;
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
