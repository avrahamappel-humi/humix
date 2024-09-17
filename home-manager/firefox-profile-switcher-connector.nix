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

  # Copy manifest file
  postInstall = ''
    mkdir -p $out/lib/mozilla/native-messaging-hosts
    substitute \
      $src/manifest/${if stdenv.isDarwin then "manifest-mac.json" else "manifest-linux.json"} \
      $out/lib/mozilla/native-messaging-hosts/ax.nd.profile_switcher_ff.json \
      --replace-fail ${if stdenv.isDarwin then "/usr/local/bin/ff-pswitch-connector" else "/usr/bin/ff-pswitch-connector"} \
      $out/bin/firefox_profile_switcher_connector
  '';

  meta = with lib; {
    description = "Native connector software for the 'Profile Switcher for Firefox' extension";
    homepage = "https://github.com/null-dev/firefox-profile-switcher-connector";
    license = licenses.gpl3Only;
    mainProgram = "firefox-profile-switcher-connector";
  };
}
