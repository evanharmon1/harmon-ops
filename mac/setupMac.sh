#!/bin/sh

# Script to setup a new developer environment on a Mac

echo Starting setupMac.sh

../git/setupGit.sh
../python/setupPython.sh

echo Installing watch...
brew install watch

echo Installing thefuck...
brew install thefuck

# Needed to get ipython and jupyter commands working on CLI - otherwise the commands weren't recognized
echo Installing IPython...
brew install ipython
echo Installing Jupyter Notebook...
brew install jupyter

echo Finished setupMac.sh