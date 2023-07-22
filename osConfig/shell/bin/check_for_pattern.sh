#!/bin/sh

 #==============================================================================
 #                       check_for_pattern
 #==============================================================================
# Check current directory recursively for given pattern occuring anywhere in
# filename and returns exit 1 if anything was found.

# -iname makes find case-insensitive
check() {
  if [[ `find . -type f -iname *$1*` ]]; then
    echo -e "\033[0;31m  $1 found!  \033[0m"
    exit 1
  else
    echo -e "\033[1;32m  $1 was not found.  \033[0m"
    exit 0
  fi
}

# Parse CLI input
if [ $# -eq 0 ]; then
  echo "usage: check_for 'search text'"
  exit 0
elif [[ $1 == "help" || $1 == "--help" || $1 == "-h" ]]; then
  echo "usage: check_for 'search text'"
  exit 0
else
  check $1
fi
