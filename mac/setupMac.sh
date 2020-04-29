#!/bin/sh

# Script to setup a new developer environment on a Mac

echo ......Starting setupMac.sh......

../git/setupGit.sh
../python/setupPython.sh
../vscode/setupVsCode.sh

brew install watch
brew install thefuck

# Needed to get ipython and jupyter commands working on CLI - otherwise the commands weren't recognized
brew install ipython
brew install jupyter

echo ======Finished setupMac.sh======