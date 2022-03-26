#!/bin/bash

# Script to setup nodejs on a new developer environment.
# Installing npm packages globally with a package.json file is not supported.

echo -e "\033[1;32m  ......Starting setupNode.sh......  \033[0m"

# Base packages
npm install -g tldr #https://github.com/tldr-pages/tldr

# Optional packages
#npm install -g gitlab-backup-util-harduino #https://www.npmjs.com/package/gitlab-backup-util-harduino

echo -e "\033[0;31m  ======Finished setupNode.sh======  \033[0m"