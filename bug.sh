#! /bin/bash

function usage {
  cat << 'EOD'
Start a bug fix script.

Usage:
bug <description>

<description> : A description of the ticket.
You can paste the thing that you get from Jira when you click "CREATE NEW BRANCH",
e.g. "git checkout -b BUG-9999-widget-is-broken"
EOD
}

# Find a script that's already been created for this bug
function find_bug_script {
  [[ $description =~ ([0-9]+) ]]

  if [ -n "${#BASH_REMATCH[@]}" ]; then
    number="${BASH_REMATCH[1]}"

    for file in $(git status -su | tr -d '?? '); do
      if [[ $file =~ $number ]]; then
        echo "$file"
        return
      fi
    done
  fi

  return 1
}

function get_dir_name {
  basename "$PWD"
}

if [[ $# == 0 ]]; then
  usage; exit
fi

dir=$(get_dir_name)

# Get the ticket description
for word in "$@"; do
  if [[ $word =~ BUG ]]; then
    description="$word"
    break
  fi
done

if [[ -z $description ]]; then
  echo "ERROR: Invalid description: $*."
  echo 'Try using the thing that you get from Jira when you click "CREATE NEW BRANCH",'
  echo 'e.g. "git checkout -b BUG-9999-widget-is-broken"'
  exit 1
fi

# Create and check out the branch
if [[ $(git branch) =~ $description ]]; then
    git checkout "$description"
else
    git checkout -b "$description"
fi

# Create the script
if [[ $dir == 'hr' ]]; then
  file=$(find_bug_script "$description") || echo "Creating script $file"

  if [[ ! -f $file ]]; then
    php artisan make:task "$(echo "$description" | tr '[:upper:]' '[:lower:]')"

    file=$(find_bug_script "$description")

    cat << 'EOD' > "$file"
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    public function up()
    {
        //
    }
};
EOD
  else
    echo "Script $file already exists"
  fi
fi

if [[ $dir == 'ableScripts' ]]; then
  file="lib/$description.rb"

  if [[ ! -f "$file" ]]; then
    echo "Creating script $file"

    cat << EOD > "$file"
Apartment::Tenant.switch! ""
EOD
  else
    echo "Script $file already exists"
  fi
fi
