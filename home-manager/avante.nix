{ vimUtils, fetchzip, hostPlatform }:

let
  src = (import ../npins)."avante.nvim";

  inherit (hostPlatform.parsed) cpu kernel;
  templatesUrl = "https://github.com/yetone/avante.nvim/releases/download/${src.version}/avante_lib-${kernel.name}-${cpu.name}-luajit.tar.gz";

  avanteTemplates = fetchzip {
    pname = "avante-templates";
    inherit (src) version;
    url = templatesUrl;
    hash = "sha256-9mXC/BWm4VBaKktvsp9REXOZLPnqYKvuHGZk6dlXnn8=";
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
