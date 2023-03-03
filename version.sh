#!/usr/bin/env bash

function help {
    echo
    echo "  Usage:"
    echo
    echo "  ./version.sh <major|minor|patch>"
    echo
    echo "  Repository must be clean"
    echo
    exit
}

function join {
    local IFS="$1"; shift; echo "$*"
}

function bump {
    local IFS="."
    local semver="$1"
    local verkey=""

    read -ra version <<< "$(git describe --abbrev=0 --tags)"

    case $semver in
        major)
        verkey=0
        ;;
        minor)
        verkey=1
        ;;
        patch)
        verkey=2
        ;;
        *)
        verkey=""
        ;;
    esac

    if [ -z "$verkey" ]; then
        echo $verkey
        exit
    fi

    next=$((${version[$verkey]} + 1))
    version[$verkey]=$next

    i=$(($verkey + 1))
    while [ $i -lt 3 ]; do
        version[$i]=0
        i=$(($i + 1))
    done

    updated=$(join . "${version[@]}")

    echo "$updated"
}

version=$(bump $1)

test -z "$(git status --porcelain)" || help
test -z "$version" && help

git tag -a "$version" -m "v$version"
echo "$version"

git push origin master --tags
