{ pkgs }:

let
  inherit (pkgs) lib makeWrapper php phpactor;
  inherit (lib.strings) concatLines hasPrefix splitString;
in
# TODO Once 2023.08.06-1 makes it to nixos-unstable, can get rid of this
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
