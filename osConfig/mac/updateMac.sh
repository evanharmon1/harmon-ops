#!/bin/bash

# Title: updateMac.sh
# Author: Evan Harmon
# Shell script to run periodically and/or automatically to keep Mac up to date
# Run this script from dev-env/mac: 
# `caffeinate -disu ./updateMac.sh`
# Don't run as root or with sudo due to homebrew not wanting to run that way for security reasons.

#============================================================================
#                               Raycast
#============================================================================
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title updateMac.sh
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 💻
# @raycast.needsConfirmation false

echo -e "\033[0;35m  ......Starting updateMac.sh......  \033[0m"
terminal-notifier -title "Starting updateMac.sh Script" \
-message "A periodic script that runs to update this Mac. Don't worry if it fails. It will try to run again later." \
-contentImage mac-icon.png \
-sound Blow


#============================================================================
# Homebrew
#============================================================================
# Updates Homebrew and then upgrades all software that was installed with Homebrew
echo -e "\033[0;35m  ......Running brew bundle to install and/or update packages in Brewfile......  \033[0m"
brew update
BREWOUTPUT=$(brew upgrade -v )
brew cleanup
echo "$BREWOUTPUT"


#============================================================================
# mackup
#============================================================================
# mackup backs up supported app configs, settings, and dotfiles like .bash_profile to iCloud and then symlinks them back to original location
# Todo: I don't think I need to run mackup at all since it symlinks to icloud...
echo -e "\033[0;35m  ......Running mackup backup to symlink any new dotfiles, config files, etc. to iCloud......  \033[0m"
# -force argument avoids confirmation dialogs
mackup backup --force

# Keep any modified dotfiles on machine in sync with dotfiles in this repo
cp ~/.bashrc ~/Dropbox/dev/DevEnv/dev-env/shell/bash
cp ~/.zshrc ~/Dropbox/dev/DevEnv/dev-env/shell/zsh
# cp ~/.fishsomething ~/Dropbox/dev/DevEnv/dev-env/shell/fish

cp ~/.dotfiles/.aliases ~/Dropbox/dev/DevEnv/dev-env/shell/
cp ~/.dotfiles/.var ~/Dropbox/dev/DevEnv/dev-env/shell/
cp ~/.dotfiles/.functions ~/Dropbox/dev/DevEnv/dev-env/shell/

cp ~/.gitconfig ~/Dropbox/dev/DevEnv/dev-env/git
cp ~/.gitignore_global ~/Dropbox/dev/DevEnv/dev-env/git

cp ~/.mackup/myDotFiles.cfg ~/Dropbox/dev/DevEnv/dev-env/mac/.mackup
cp ~/.mackup.cfg ~/Dropbox/dev/DevEnv/dev-env/mac/.mackup

#============================================================================
# Python
#============================================================================
# ../python/setupPython.sh

#============================================================================
# JavaScript
#==============================================================================
# ../javascript/setupJavascript.sh

# This pipes the output from brew bundle to the macOS notification
# This is supposed to open the output file but the command doesn't work.
echo "$BREWOUTPUT" | tail -3 | terminal-notifier -title "Finished updateMac.sh Script" \
-contentImage /Users/evan/Dropbox/dev/DevEnv/dev-env/mac/monitor-icon.icns \
-execute "nova /private/tmp/updateMac.out" \
-sound Glass

echo -e "\033[1;32m  ======Finished updateMac.sh======  \033[0m"
