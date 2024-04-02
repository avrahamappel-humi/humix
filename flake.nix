{
  description = "Local dev setup";

  inputs = {
    # XZ exploit, pinning to unexploited version until official patch is available https://nixpk.gs/pr-tracker.html?pr=300028
    nixpkgs.url = "nixpkgs/8db50d6f207f6e6bea072986fe5abfc955f04bfc";
    nixpkgs-libxml-2-11.url = "nixpkgs/b0d36bd0a420ecee3bc916c91886caca87c894e9";
  };

  outputs =
    { nixpkgs, nixpkgs-libxml-2-11, flake-utils, ... }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };

      # nokogiri is currently blocked from compiling on nixos unstable
      # [d870193](https://github.com/NixOS/nixpkgs/pull/274550/commits/d870193b2d99dc2744cee8111468135e4c83bde2)
      # and above due to changes in libxml2 which cause compiler errors.
      # This is solved in Nokogiri v1.16.0.rc1 and above. See https://github.com/sparklemotion/nokogiri/issues/3071
      oldPkgs = import nixpkgs-libxml-2-11 { inherit system; };

      # To update, run ./update.sh (also updates the flake)
      ngserver = (pkgs.callPackage ./ngserver {
        inherit pkgs system;
      }).nodeDependencies;

      stylelint-lsp = (pkgs.callPackage ./stylelint-lsp {
        inherit pkgs system;
      }).nodeDependencies;

      humix = pkgs.callPackage ./humix.nix {
        projects = pkgs.callPackage ./projects.nix { } {
          inherit ngserver oldPkgs stylelint-lsp;
        };
      };
    in
    {
      packages.default = humix.humix-setup;

      inherit (humix) devShells;
    });
}
