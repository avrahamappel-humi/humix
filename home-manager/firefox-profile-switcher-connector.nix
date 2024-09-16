{ lib
, rustPlatform
, stdenv
, darwin
, cmake
}:

let
  src = (import ../npins).firefox-profile-switcher-connector;
in

rustPlatform.buildRustPackage {
  pname = "firefox-profile-switcher-connector";

  inherit src;
  inherit (src) version;

  cargoHash = "sha256-CNalAHDhSYsB4qvjGCte9jVK4m1etbAdpzgZN3PeNMk=";

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  nativeBuildInputs = [ cmake ]; # Required by nng-sys

  meta = with lib; {
    description = "Native connector software for the 'Profile Switcher for Firefox' extension";
    homepage = "https://github.com/null-dev/firefox-profile-switcher-connector";
    license = licenses.gpl3Only;
    mainProgram = "firefox-profile-switcher-connector";
  };
}
