#!/bin/bash

# Script to setup a new developer environment on a *nix computer

echo -e "\033[1;32m  ......Starting setupNix.sh......  \033[0m"

apt update

apt install software-properties-common

apt install tmux
apt install python3
apt install nodejs
snap install code --classic
apt install watch
apt install thefuck

apt install sqlite3
apt install postgresql postgresql-contrib
apt install mongodb
snap install robo3t-snap
apt install default-jdk
apt install jmeter
apt install virtualbox
apt install vagrant
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible

# Needed to get ipython and jupyter commands working on CLI - otherwise the commands weren't recognized
apt install ipython
apt install jupyter

../python/setupPython.sh
../node/setupNode.sh
../git/setupGit.sh
../vscode/setupVsCode.sh

apt upgrade

echo -e "\033[0;31m  ======Finished setupNix.sh======  \033[0m"