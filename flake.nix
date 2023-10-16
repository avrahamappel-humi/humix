{
  description = "Local dev setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-php-8-1-9.url = "nixpkgs/646edf48542caaf4ee418d03efc0f754b7adc409";
    nixpkgs-composer-2-6-5.url = "nixpkgs/3360cb0bb03325383508727d403186518e18fd6b";
    nixpkgs-node-20-5-1.url = "nixpkgs/540a97984288db83d642812565fb43f276b02f21";
    nixpkgs-node-18-18-1.url = "nixpkgs/b51626e173687365d695e1d2c6769a66753bc00e";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , nixpkgs-php-8-1-9
    , nixpkgs-composer-2-6-5
    , nixpkgs-node-20-5-1
    , nixpkgs-node-18-18-1
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
      composer-2-6-5 =
        (import nixpkgs-composer-2-6-5 { inherit system; }).phpPackages.composer;

      # for hr
      node-20-5-1 = (import nixpkgs-node-20-5-1 { inherit system; }).nodejs_20;

      # for ui
      node-18-18-1 =
        (import nixpkgs-node-18-18-1 { inherit system; }).nodejs_18;

      # for angular templates
      # To update this, cd into ./ngserver and run
      # nix-shell -p node2nix --run node2nix
      # @angular/language-server is pinned at 16.1.4 until
      # humility is on typescript 5
      ngserver = (pkgs.callPackage ./ngserver { inherit pkgs system; }).nodeDependencies;

      humix = pkgs.callPackage ./humix.nix {
        projects = import ./projects.nix {
          inherit pkgs php-8-1-9 composer-2-6-5 node-20-5-1 node-18-18-1 ngserver;
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
