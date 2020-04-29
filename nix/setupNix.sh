#!/bin/sh

# Script to setup a new developer environment on a *nix computer

echo ......Starting setupNix.sh......

apt install nodejs
apt install python3

../git/setupGit.sh
../python/setupPython.sh
../vscode/setupVsCode.sh

apt install watch
apt install thefuck

# Needed to get ipython and jupyter commands working on CLI - otherwise the commands weren't recognized
apt install ipython
apt install jupyter

echo ======Finished setupNix.sh======