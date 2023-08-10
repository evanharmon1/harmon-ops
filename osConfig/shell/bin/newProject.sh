#!/bin/sh

 #==============================================================================
 #                       newProject.sh
 #==============================================================================
# Script to help setup a new programming project
# Run from my ~/dev folder and gets files from harmon-ops/dev/newProjectTemplate folder
# Author: Evan Harmon

# Fail fast
set -Eeuo pipefail

# Attempt to clean up - like a "finally" block
trap cleanup SIGINT SIGTERM ERR EXIT

# Helps to e.g. execute from different environments or CI, etc.
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF # remove the space between << and EOF, this is due to web plugin issue
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -p param_value arg1 [arg2...]

Script description here.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-f, --flag      Some flag description
-n, --name      name of project
-g, --git       name of git repo to create
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

main() {
  mkdir "$name"
  cd "$name"
  git init "$git"
  touch "note${name}.md"
  echo "$noteText" >> "note${name}.md"
  cd "$git"
  cp -R ~/dev/HarmonOps/harmon-ops/dev/newProjectTemplate/ .
  echo "$readmeText" >> "README.md"
  mv newProject.code-workspace ../"$name.code-workspace"
  cd ..
  open https://www.toptal.com/developers/gitignore
  open "$name.code-workspace"
  echo "$name project successfully created in $(pwd)"
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg="$1"
  local code="${2-1}" # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  name=''
  git=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -n | --name) # name of project
      name="${2-}"
      shift
      ;;
    -g | --git) # name of project
      git="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  # check required params and arguments
  [[ -z "${name-}" ]] && die "Missing required parameter: name"
  [[ -z "${git-}" ]] && die "Missing required parameter: git"

  return 0
}

parse_params "$@"
setup_colors

msg "${RED}Read parameters:${NOFORMAT}"
msg "- name: ${name}"
msg "- git: ${git}"


# shellcheck disable=SC2006
readmeText=$(cat <<EOF
# ${name} Readme

## Setup
1. Install Homebrew if needed: \`bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"\`
2. Install [Taskfile](https://taskfile.dev/): \`brew install go-task/tap/go-task\`
### Run install script with Taskfile.yml
\`task install\`

## Usage
### Taskfile Task Runner
\`task validate\`

EOF
)

noteText=$(cat <<EOF
# ${name} Notes

## Todo

## Issues

## Sources

## Inbox

EOF
)

main
