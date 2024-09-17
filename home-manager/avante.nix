{ stdenv, vimUtils, fetchzip }:

let
  src = (import ../npins)."avante.nvim";

  platform = if stdenv.isDarwin then "macos" else "ubuntu";
  templatesUrl = "https://github.com/yetone/avante.nvim/releases/download/${src.version}/avante_lib-${platform}-latest-luajit.tar.gz";

  avanteTemplates = fetchzip {
    pname = "avante-templates-${platform}";
    inherit (src) version;
    url = templatesUrl;
    sha256 = "00fr1jada7cfc9m2xlfa5vkzj1sy5b5hvny8jannsdkfiyrryqi1";
    stripRoot = false;
  };

  avantePlugin = vimUtils.buildVimPlugin {
    pname = "avante.nvim";
    inherit (src) version;

    inherit src;

    postInstall = ''
      echo "Installing templates"
      ln -s ${avanteTemplates} $out/build
    '';
  };
in

avantePlugin
