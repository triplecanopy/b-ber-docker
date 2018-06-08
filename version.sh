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
        help
        ;;
    esac

    next=$((${version[$verkey]} + 1))
    version[$verkey]=$next
    updated=$(join . "${version[@]}")

    echo "$updated"
}

test -z "$(git status --porcelain)" || help

version=$(bump $1)

git tag -a "$version" -m "v$version"
echo "$version"

git push origin master --tags
