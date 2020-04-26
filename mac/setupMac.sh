#!/bin/sh

echo Starting setupMac.sh

../git/setupGit.sh

echo Installing watch...
brew install watch

echo Installing thefuck...
brew install thefuck

echo Finished setupMac.sh