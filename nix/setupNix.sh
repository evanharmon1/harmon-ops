#!/bin/sh

echo Starting setupNix.sh

../git/setupGit.sh

echo Installing watch...
apt install watch

echo Installing thefuck...
apt install thefuck

echo Finished setupNix.sh