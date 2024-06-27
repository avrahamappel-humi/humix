{ pkgs, lib, ... }:

let
  pathToHumility = "~/humility";

  projectAliases = builtins.listToAttrs
    (builtins.map
      (project: { name = project; value = "humility_open ${project} $*"; })
      [ "hr" "payroll" "ui" "admin" "ableScripts" ]);
in

{
  home.shellAliases = {
    d = "docker $*";
    dc = "docker compose $*";
    dcd = "docker compose down --remove-orphans -t 1";
    humi = "cd ${pathToHumility} && ./humility $*";
    # Start frontend build
    hfe = "ui && tmux new -A -s ng yarn nx-high-memory run hr-angular:serve";
    # Start backend in docker
    hbe = "humi && tmux new -A -s dc docker compose up --scale ui=0";
  } // projectAliases;

  programs.zsh.initExtra = ''
    ##################
    # HUMILITY STUFF #
    ##################

    function humility_open() {
        mode="cd"
        project="$1"
        shift

        if test $# -gt 0
        then
            case "$1" in
                "-e")
                    mode="edit"
                    ;;
                "-d")
                    mode="docker"
                    ;;
            esac
            shift
        fi

        cd ~/humility/applications/$project

        case $mode in
            "edit")
                # Open the project in a Tmux session with the Git window open
                tmux new -A -s "$project" nvim . +"vert Git"
                ;;
            "docker")
                # If container isn't running, start it
                container_running "$project" || docker compose up $project -d

                # Get the rest of the arguments, we might be trying to run a specific command
                if test $# -gt 0
                then
                    docker compose exec $project $@
                else
                    docker compose exec $project bash
                fi
                ;;
        esac
    }

    function container_running() {
        name="$1"
        running_containers="$(docker compose ps | tail -n +2 | awk '{ print $1; }')"

        if (( ''${running_containers[(Ie)$name]} ))
        then
            return 0
        else
            return 1
        fi
    }
  '';

  programs.git.includes = [
    {
      condition = "gitdir:~/humility/";
      path = "~/.gitconfig-humi";
    }
  ];

  home.file.".jira.d/config.yml".text = ''
    endpoint: https://gethumi.atlassian.net
    user: avraham.appel@humi.ca
    password-source: keyring
  '';

  home.packages = with pkgs; [
    gh
    go-jira
  ];

  programs.neovim.plugins = with pkgs; [
    {
      # Prettier
      plugin = vimPlugins.vim-prettier;
      type = "viml";
      config = /* vim */ ''
        let g:prettier#autoformat = 1
        let g:prettier#autoformat_require_pragma = 0
        let g:prettier#exec_cmd_async = 1
        let g:prettier#quickfix_enabled = 0
      '';
    }
    {
      # Some angular stuff
      plugin = vimUtils.buildVimPlugin {
        pname = "ng.nvim";
        version = "2023-02-12";
        src = fetchFromGitHub {
          owner = "joeveiga";
          repo = "ng.nvim";
          rev = "d02deda535e1b05014ce4f36781d2f45c174065a";
          hash = "sha256-9Koecth1grLq01OCFYkB/qMl2xlAst5No5ZPRBnuLU8=";
        };
      };
      type = "lua";
      config = /* lua */ ''
        local opts = { noremap = true, silent = true }
        local ng = require("ng");
        vim.keymap.set("n", "<leader>t", ng.goto_template_for_component, opts)
        vim.keymap.set("n", "<leader>r", ng.goto_component_with_template_file, opts)
      '';
    }
    {
      # chat-gpt
      plugin = vimPlugins.ChatGPT-nvim;
      type = "lua";
      config = /* lua */ ''
        require('chatgpt').setup {
          api_key_cmd = 'security find-generic-password -s humi-chatgpt-key -w',
        }
      '';
    }
    {
      # Xdebug in vim
      plugin = vimUtils.buildVimPlugin {
        pname = "vdebug";
        version = "latest";
        src = fetchFromGitHub {
          owner = "vim-vdebug";
          repo = "vdebug";
          rev = "master";
          hash = "sha256-hIzhHvTOXA+mw38R3JKYp94QCJWZhEcTTnqhHhW9OW8=";
        };
      };
      type = "viml";
      config = /* vim */ ''
        if !exists('g:vdebug_options')
          let g:vdebug_options = {}
        endif

        let g:break_on_open = 0
        let g:vdebug_options.port = 9003
        let g:vdebug_options.debug_file = '~/.local/share/vdebug/vdebug.log'
        let g:vdebug_options.debug_file_level = 1
        " File mappings. Add more as needed
        let g:vdebug_options.path_maps = { "/var/www/hr": getcwd() }
      '';
    }
  ];
  # Vdebug uses python3
  programs.neovim.withPython3 = lib.mkForce true;
}
