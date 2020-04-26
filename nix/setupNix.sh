#!/bin/sh

# Script to setup a new developer environment on a *nix computer

echo Starting setupNix.sh

../git/setupGit.sh
../python/setupPython.sh

echo Installing watch...
apt install watch

echo Installing thefuck...
apt install thefuck

# Needed to get ipython and jupyter commands working on CLI - otherwise the commands weren't recognized
echo Installing IPython...
apt install ipython
echo Installing Jupyter Notebook...
apt install jupyter

echo Finished setupNix.sh