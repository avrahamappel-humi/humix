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
}
