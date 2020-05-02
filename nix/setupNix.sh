#!/bin/bash

# Script to setup a new developer environment on a *nix computer

# Packages - apt install aPackage
# Need to apt install ipython and jupyter below to get their commands working on CLI - otherwise the commands weren't recognized.
PACKAGES=(
    software-properties-common
    ansible
    tmux
    python3
    ipython
    jupyter
    nodejs
    watch
    thefuck
    postgresql
    postgresql-contrib
    sqlite3
    mongodb
    default-jdk
    jmeter
    virtualbox
    vagrant
    ffmpeg
    git
    graphviz
    imagemagick
    markdown
    tree
    vim
    wget
)

# Snaps - snap install aSnap
SNAPS=(
    code --classic
    robo3t-snap
)

echo -e "\033[1;32m  ......Starting setupNix.sh......  \033[0m"

apt update

apt-add-repository --yes --update ppa:ansible/ansible

apt install ${PACKAGES[@]}

snap install ${SNAPS[@]}

../python/setupPython.sh
../node/setupNode.sh
../git/setupGit.sh
../vscode/setupVsCode.sh

apt upgrade

echo -e "\033[0;31m  ======Finished setupNix.sh======  \033[0m"