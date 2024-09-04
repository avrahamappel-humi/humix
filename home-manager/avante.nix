{ pkgs, stdenv, vimUtils }:

let
  srcs = import ../npins;

  avanteSource = stdenv.mkDerivation {
    name = "avante-source";
    version = srcs."avante.nvim".version;

    src = srcs."avante.nvim";

    CARGO_HOME = "./cargo";
    # Fails with SSL error from netskope
    # CARGO_HTTP_CHECK_REVOKE = "false";
    # CARGO_NET_GIT_FETCH_WITH_CLI = "true";

    preBuild = ''
      mkdir $CARGO_HOME
    '';

    makeFlags = [ "BUILD_FROM_SOURCE=true" ];

    buildInputs = with pkgs; [
      cargo
      git
      # oniguruma
      # openssl
      # darwin.apple_sdk.frameworks.Security
    ];

    nativeBuildInputs = with pkgs; [
      # pkg-config
    ];
  };

  avantePlugin = vimUtils.buildVimPlugin {
    pname = "avante.nvim";
    version = srcs."avante.nvim".version;
    src = avanteSource;
  };
in

avantePlugin
