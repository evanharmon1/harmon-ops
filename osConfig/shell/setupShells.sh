#!/bin/sh -x

# This script is not needed on a Mac if you setup mackup as the setupMac.sh script does.
mkdir ~/.dotfiles
cp .aliases ~/.dotfiles
cp .env ~/.dotfiles
cp .functions ~/.dotfiles

# setup bash
cp bash/.bashrc ~

# setup zsh
cp zsh/.zshrc ~

# setup fish
