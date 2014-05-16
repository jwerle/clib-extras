#!/bin/bash

if [ -z "${REPOS}" ]; then
  {
    echo "Nothing to install"
    exit -1
  } >&2
fi

REPOS=($(echo ${REPOS}))
let len=${#REPOS[@]}
let i=0

for ((i = 0; i < len; ++i)); do
  clib install ${REPOS[$i]}
done
