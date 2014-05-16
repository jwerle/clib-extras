#!/bin/bash

## completion file
COMPLETION_FILE="${HOME}/.clib-completions.sh"

## ensure there are repos
if [ -z "${REPOS}" ]; then
  {
    echo "Nothing to install"
    exit -1
  } >&2
fi

## known clib commands
KNOWN_CMDS="install search help"

## completion list
COMPLETIONS="`echo ${KNOWN_CMDS} ${REPOS} | tr '\n' ' '`"
{
  TMP=($(echo ${COMPLETIONS}))
  COMPLETIONS=""
  let i=0;
  let len=${#TMP[@]}
  for ((i = 0; i < len; ++i)); do
    COMPLETIONS+="`echo ${TMP[$i]} | sed 's/.*\///' | sed 's/clib-//'` "
  done
}

## to array
REPOS=($(echo ${REPOS}))
let len=${#REPOS[@]}
let i=0

## install
for ((i = 0; i < len; ++i)); do
  clib install ${REPOS[$i]}
done

if test -f "${COMPLETION_FILE}"; then
  rm -f "${COMPLETION_FILE}"
  touch "${COMPLETION_FILE}"
fi

cat >> "${COMPLETION_FILE}" << COMPLETION_FILE
## completions
_extra() {
  local cur=\${COMP_WORDS[COMP_CWORD]}
  local comp="$(echo ${COMPLETIONS} | tr -d '\n')"
  COMPREPLY=( \$(compgen -W "\${comp}" -- \${cur}) )
}

complete -F _extra clib
COMPLETION_FILE

. "${COMPLETION_FILE}"

echo "Add this line to your \`.bashrc' or \`.bash_profile': "
echo "test -f ${COMPLETION_FILE} && . ${COMPLETION_FILE}"

exit $?
