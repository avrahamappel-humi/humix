{ pkgs, pkgs-unstable, ... }:

let
  open-ai-key-cmd = "security find-generic-password -s humi-chatgpt-key -w";

  avante = pkgs.callPackage ./avante.nix { };
in

{
  programs.neovim = {
    plugins = with pkgs; [
      # avante.nvim dependencies
      vimPlugins.nui-nvim
      vimPlugins.dressing-nvim
      {
        plugin = pkgs-unstable.vimPlugins.render-markdown-nvim;
        type = "lua";
        config = /* lua */ ''
          require('render-markdown').setup {
            file_types = { 'Avante' },
          }
        '';
      }

      # Avante
      {
        plugin = avante;
        type = "lua";
        config = /* lua */ ''
          require('avante_lib').load()
          require('avante').setup {
            provider = "openai",
            openai = {
              api_key_name = 'cmd:${open-ai-key-cmd}'
            },
            mappings = {
              ask = "<leader>oa",
              edit = "<leader>oe",
              refresh = "<leader>or",
              toggle = {
                default = "<leader>ot",
                debug = "<leader>od",
                hint = "<leader>oh",
              },
            },
          }
        '';
      }
    ];
  };
}
