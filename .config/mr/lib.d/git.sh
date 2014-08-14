#!/bin/bash

GIT_URL_REGEX='^(([a-z+]+)://)?(([-a-zA-Z0-9\._]+)?@?([-a-zA-Z0-9\._]+):?([1-9][0-9]+)?)?([-a-zA-Z0-9\./_~]+)$'

setup_gerrit() {
    local remote=$(git ls-remote --get-url)
    if [[ $remote =~ $GIT_URL_REGEX ]]
    then
        local user="${BASH_REMATCH[4]}"
        local host="${BASH_REMATCH[5]}"
        local port="${BASH_REMATCH[6]}"

        if [ "$port" == "29418" ] && [ ! -f .git/hooks/commit-msg ]
        then
            scp -P 29418 $user@$host:hooks/commit-msg .git/hooks/
        fi
    fi

}
