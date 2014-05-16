#!/bin/bash

if [ -z "${REPOS}" ]; then
  {
    echo "Nothing to uninstall"
    exit -1
  } >&2
fi

REPOS=($(echo ${REPOS}))
let len=${#REPOS[@]}
let i=0

if ! type -f clib-uninstall > /dev/null 2>&1; then
  {
    echo "Missing \`clib-uninstall'"
    exit -1
  }
fi

for ((i = 0; i < len; ++i)); do
  clib uninstall ${REPOS[$i]}
done
