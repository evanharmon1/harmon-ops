#!/bin/bash

# Script to setup a new developer environment on a Mac

echo -e "\033[1;32m  ......Starting setupMac.sh......  \033[0m"

brew update

brew install bash # Installs newer version of Bash on top of system Bash
chsh -s /usr/local/bin/bash
brew install tmux
brew install python
brew install node
brew install git
brew install visual-studio-code
brew install virtualbox
brew install vagrant
pip install --user ansible
brew install watch
brew install thefuck

# Needed to get ipython and jupyter commands working on CLI - otherwise the commands weren't recognized
brew install ipython
brew install jupyter

../python/setupPython.sh
../node/setupNode.sh
../git/setupGit.sh
../vscode/setupVsCode.sh

brew upgrade

echo -e "\033[0;31m  ======Finished setupMac.sh======  \033[0m"
echo -e "\033[0;33m  *Need to add /usr/local/bin/bash to the bottom of the list at /etc/shells \033[0m"