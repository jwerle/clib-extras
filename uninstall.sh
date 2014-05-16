#!/bin/bash

## completion file
COMPLETION_FILE="${HOME}/.clib-completions.sh"

## ensure there is something to uninstall
if [ -z "${REPOS}" ]; then
  {
    echo "Nothing to uninstall"
    exit -1
  } >&2
fi

## convert to array
REPOS=($(echo ${REPOS}))
let len=${#REPOS[@]}
let i=0

## ensure command exists
if ! type -f clib-uninstall > /dev/null 2>&1; then
  {
    echo "Missing \`clib-uninstall'"
    exit -1
  }
fi

## uninstall
for ((i = 0; i < len; ++i)); do
  clib uninstall ${REPOS[$i]}
done

## remove completion file
rm -f "${COMPLETION_FILE}"
