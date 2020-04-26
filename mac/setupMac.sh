#!/bin/sh

# Script to setup a new developer environment

echo Starting setupMac.sh

../git/setupGit.sh
../python/setupPython.sh

echo Installing watch...
brew install watch

echo Installing thefuck...
brew install thefuck

# Needed to get ipython and jupyter commands working on CLI
echo Installing IPython...
brew install ipython
echo Installing Jupyter Notebook...
brew install jupyter

echo Finished setupMac.sh