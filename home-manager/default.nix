{ pkgs, lib, config, ... }:

let
  pathToHumility = "~/humility";
  pathToHumix = "${pathToHumility}/user_files/humix";

  projectAliases = builtins.listToAttrs
    (builtins.map
      (project: { name = project; value = "humility_open ${project} $*"; })
      [ "hr" "payroll" "ui" "admin" "ableScripts" ]);

  srcs = import ../npins;

  inherit (pkgs) vimUtils vimPlugins;
  inherit (config.nur.repos.rycee) firefox-addons mozilla-addons-to-nix;

  open-ai-key-cmd = "security find-generic-password -s humi-chatgpt-key -w";
in

{
  nixpkgs.config.allowUnfree = true;

  home.shellAliases = {
    d = "docker $*";
    dc = "docker compose $*";
    dcd = "docker compose down --remove-orphans -t 1";
    humi = "cd ${pathToHumility} && ./humility $*";
    # Start frontend build
    hfe = "ui && tmux new -A -s ng yarn nx-high-memory run hr-angular:serve";
    # Start backend in docker
    hbe = "humi && tmux new -A -s dc docker compose up --scale ui=0";

    # Navigate to this project
    hx = "cd ${pathToHumix}";
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

  # Git
  programs.git.includes = [
    {
      condition = "gitdir:${pathToHumility}";
      contents = {
        credential.helper = "${pkgs.gh}/bin/gh auth git-credential";
        user = {
          name = "Avraham Appel";
          email = "avraham.appel@humi.ca";
          signingKey = "8C7B110A817B77CC";
        };
        commit.gpgSign = true;
      };
    }
  ];

  home.packages = with pkgs; [
    coreutils
    gh
    mozilla-addons-to-nix
  ];

  programs.neovim.plugins = [
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
        version = "latest";
        src = srcs."ng.nvim".outPath;
      };
      type = "lua";
      config = /* lua */ ''
        local opts = { noremap = true, silent = true }
        local ng = require("ng");
        vim.keymap.set("n", "<leader>t", ng.goto_template_for_component, opts)
        vim.keymap.set("n", "<leader>u", ng.goto_component_with_template_file, opts)
      '';
    }
    {
      # chat-gpt
      plugin = vimPlugins.ChatGPT-nvim;
      type = "lua";
      config = /* lua */ ''
        require('chatgpt').setup {
          api_key_cmd = '${open-ai-key-cmd}',
          openai_params = {
            model = 'gpt-4o',
            max_tokens = 4096,
          },
        }
      '';
    }

    {
      # Linear
      plugin = vimUtils.buildVimPlugin {
        pname = "linear-nvim";
        version = "latest";
        src = srcs.linear-nvim.outPath;
      };
      type = "lua";
      config = /* lua */ ''
        local linear_nvim = require("linear-nvim")
        linear_nvim.setup {
          issue_regex = "PAY%-%d+",
        }
        vim.keymap.set("n", "<leader>j", function()
          linear_nvim.show_assigned_issues()
        end)
      '';
    }
    vimPlugins.telescope-nvim
    {
      # Xdebug in vim
      plugin = vimUtils.buildVimPlugin {
        pname = "vdebug";
        version = "latest";
        src = srcs.vdebug.outPath;
      };
      type = "viml";
      config = /* vim */ ''
        if !exists('g:vdebug_options')
          let g:vdebug_options = {}
        endif

        let g:vdebug_options.break_on_open = 0
        let g:vdebug_options.port = 9003
        let g:vdebug_options.debug_file = '~/.local/share/vdebug/vdebug.log'
        let g:vdebug_options.debug_file_level = 1
        " File mappings. Add more as needed
        let g:vdebug_options.path_maps = {
        \  "/var/www/hr": getcwd(),
        \  "/var/www/admin": getcwd(),
        \}
      '';
    }
  ];
  # Vdebug uses python3
  programs.neovim.withPython3 = lib.mkForce true;

  programs.skhd.hotApps = [
    "Alacritty"
    "Firefox"
    "Mail"
    "Slack"
  ];

  # Extra Firefox addons
  programs.firefox.profiles.work =
    let
      defaults = config.firefoxProfileDefaults;
      local-addons = pkgs.callPackage ./generated-firefox-addons.nix {
        inherit (firefox-addons) buildFirefoxXpiAddon;
      };
    in
    defaults // {
      id = 1;
      extensions = defaults.extensions ++ [
        firefox-addons.angular-devtools
        firefox-addons.okta-browser-plugin
        local-addons.fellow
        local-addons.keeper-password-manager
        # humi-feature-flag-portal
      ];
    };
}
