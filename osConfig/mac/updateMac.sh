#!/bin/zsh

# Title: updateMac.sh
# Author: Evan Harmon
# Shell script to run periodically and/or automatically to keep Mac up to date
# Run this script from the repo's osConfig/mac directory: 
# `caffeinate -disu bash -x ./updateMac.sh 2>&1 | tee ~/.log/updateMac.sh.log`
# Don't run as root or with sudo due to homebrew not wanting to run that way for security reasons.

#============================================================================
#                               Raycast
#============================================================================
# To run this script via Raycast
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title updateMac.sh
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 💻
# @raycast.needsConfirmation false

echo -e "\033[0;35m  ......Starting updateMac.sh......  \033[0m"
terminal-notifier -title "Starting updateMac.sh Script" \
-message "A script that updates this Mac's Homebrew, Mackup dotfiles, etc." \
-contentImage mac-icon.png \
-sound Blow


#============================================================================
# Homebrew
#============================================================================
# Updates Homebrew and then upgrades all software that was installed with Homebrew
echo -e "\033[0;35m  ......Running brew bundle to install and/or update packages in Brewfile......  \033[0m"
brew update
BREWOUTPUT=$(brew upgrade -v )
echo "$BREWOUTPUT"
brew cleanup -v
brew bundle dump -v --describe --force --file=~/Brewfile
THIS_HOST=$(HOSTNAME)
mkdir "../../infra/${THIS_HOST}/"
\cp -fR ~/Brewfile "../../infra/${THIS_HOST}/"


#============================================================================
# dotfiles & Mackup
#============================================================================
# mackup backs up supported app configs, settings, and dotfiles like .bash_profile to iCloud and then symlinks them back to original location
# The only reason I think I need to keep running mackup backup is to catch new files that aren't symlinked to iCloud.
echo -e "\033[0;35m  ......Running mackup backup to symlink any new dotfiles, config files, etc. to iCloud......  \033[0m"
# -force argument avoids confirmation dialogs
mackup backup --force

# Keep any modified dotfiles on machine in sync with dotfiles in this repo
rsync -ah --copy-links ~/.bashrc ../shell/bash
rsync -ah --copy-links ~/.zshrc ../shell/zsh/

rsync -ah --copy-links ~/.dotfiles/ ../shell/.dotfiles/

rsync -ah --copy-links ~/.gitconfig ../git/
rsync -ah --copy-links ~/.gitignore_global ../git/

rsync -ah --copy-links ~/.mackup/myDotFiles.cfg .mackup/
rsync -ah --copy-links ~/.mackup.cfg .mackup


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
