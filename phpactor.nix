{ pkgs }:

let
  inherit (pkgs) lib makeWrapper php phpactor;
  inherit (lib.strings) concatLines hasPrefix splitString;
in
# See https://github.com/NixOS/nixpkgs/pull/254817
phpactor.overrideAttrs (final: prev: {
  nativeBuildInputs = [ makeWrapper ];
  installPhase = concatLines
    (map
      (line:
        if (hasPrefix "ln" line) then ''
          makeWrapper ${php}/bin/php $out/bin/phpactor \
          --add-flags "$out/share/php/phpactor/bin/phpactor"
        ''
        else line
      )
      (splitString "\n" prev.installPhase));
})
