#!/bin/bash

# Checks if current branch matches JIRA pattern (ABC-1234-anything),
# then adds ABC-1234 to start of commit message.
# Originally written by @john-humi

BRANCH_NAME=$(git branch 2>/dev/null | grep -e ^* | tr -d ' *')

REGEX='^([a-zA-Z]{2,4}-[0-9]+)-*'

if [ -n "$BRANCH_NAME" ]; then
    [[ $BRANCH_NAME =~ $REGEX ]]

    if [ -n "$BASH_REMATCH" ]; then
        ticket_number="$(echo "${BASH_REMATCH[1]}" | tr '[:lower:]' '[:upper:]')"
        echo "$ticket_number $(cat $1)" > $1
    fi
fi
