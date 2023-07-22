#!/bin/sh -x

#==============================================================================
#                       Setup Mac
#==============================================================================
# Author: Evan Harmon
# Main script to initiate the automated setup of a new Mac
# Follow the prerequisite steps listed in CHECKLIST-MAC.md
# E.g., install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
# Run this script from the repo's osConfig/mac directory:
# `caffeinate -disu zsh -x ./setupMac.sh 2>&1 | tee -a ~/.log/setupMac.sh.log`
# Don't run as root or with sudo due to homebrew not wanting to run that way for security reasons.

echo -e "\033[0;35m  ++++++Starting setupMac.sh - $(date) "+%FT%T"++++++  \033[0m"
start_time=$(date +%s)

#============================================================================
#                               Apple Software Updates
#============================================================================
echo -e "\033[0;35m  ......Checking for and installing any Apple software updates......  \033[0m"
# Mac system software and App Store updates and restart if needed
softwareupdate --install --all --restart —verbose


#============================================================================
#                               Homebrew
#============================================================================
echo -e "\033[0;35m  ......Running brew bundle to install packages listed in ~/Brewfile......  \033[0m"
brew update -v
brew upgrade -v
brew bundle -v --file=~/Brewfile
brew bundle dump -v --describe --force --file=~/Brewfile
THIS_HOST=$(HOSTNAME)
mkdir "../../infra/${THIS_HOST}/"
\cp -fR ~/Brewfile "../../infra/${THIS_HOST}/"


#============================================================================
#                               Directories and Symbolic Links
#============================================================================
echo -e "\033[0;35m  ......Making Directories and Symbolic Links......  \033[0m"
mkdir ~/Local
mkdir ~/Local/Banktivity
mkdir ~/Local/TorrentsIncomplete
touch ~/Local/.secret
mkdir ~/.log
touch ~/.log/setupMac.sh.log
touch ~/.log/updateMac.sh.log
touch ~/.log/updateMacSoftware.sh.log
touch ~/.log/updateJavaScript.sh.log
touch ~/.log/updatePython.sh.log
# You can't use relative paths for symoblic links apparently. E.g. - osCongig/mac/scripts
ln -s ~/Dropbox/dev ~/
ln -s ~/dev/HarmonOps/harmon-ops/osConfig/shell/bin ~/
ln -s ~/dev/HarmonOps/harmon-ops/osConfig/mac/scripts ~/


#============================================================================
#                               Zsh
#============================================================================
echo -e "\033[0;35m  ......Installing oh-my-zsh......  \033[0m"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


#============================================================================
#                               Python
#============================================================================
../languages/python/setupPython.sh


#============================================================================
#                               JavaScript
#============================================================================
../languages/javaScript/setupJavaScript.sh


#============================================================================
#                               JavaScript
#============================================================================
../languages/java/setupJava.sh


#============================================================================
#                               VS Code
#============================================================================
# Shouldn't need this anymore with VS Code Settings Sync unless I want to start from scratch.
# echo -e "\033[0;35m  ......Installing Fonts......  \033[0m"
# ../IDEs/vscode/setupVsCode.sh


#============================================================================
#                               Fonts
#============================================================================
git clone https://github.com/powerline/fonts.git
./fonts/install.sh


#============================================================================
#                               mackup for dotfiles
#============================================================================
# `mackup` backs up supported app configs, settings, and dotfiles like .bash_profile to iCloud and then symlinks them back to original location
# .mackup.cfg specifies cloud storage destination. It needs to be in home directory
# mackup config needs the .mackup.cfg in the home directory and a ~/.mackup directory with
# the myDotFiles.cfg file, but all those should be part of what mackup backup and mackup restore handles
echo -e "\033[0;35m  ......Running mackup restore to symlink existing app config, settings, and dotfiles from iCloud to their default local locations......  \033[0m"
# Backup current Mackup directory in iCloud in case the restore process messes up anything.
mkdir -p ~/Library/"Mobile Documents"/com~apple~CloudDocs/Backups/"Mackup Backups/${THIS_HOST}/$(date +%F)"/
cp ~/Library/"Mobile Documents"/com~apple~CloudDocs/Mackup ~/Library/"Mobile Documents"/com~apple~CloudDocs/Backups/"Mackup Backups/${THIS_HOST}/$(date +%F)"/
ln -s ~/Library/"Mobile Documents"/com~apple~CloudDocs/Mackup/.mackup.cfg ~/
mackup restore


#============================================================================
#                               macOS Settings via Terminal
#============================================================================
# TODO: Try without this next time. Not sure it's worth it. And hard to diagnose bugs. So maybe split it off into a separate files - configureMacSettingsSuperset.sh and configureMacSettings.sh for vetted commands that I know work correctly.
# echo -e "\033[0;35m  ......Configuring Mac settings with terminal commands......  \033[0m"
# ./configureMacSettings.sh


#============================================================================
#                               Apple launchd Service for updateMac.sh
#============================================================================
# Setup updateMac.sh script as a launchd/launchctl service to run automatically once a week and at startup
# TODO: Try without this next time to see if it doesn't recreate that file not found bug I get on my MacBook Pro
# echo -e "\033[0;35m  ......Setting up updateMac.sh as an Apple launchd service to run automatically......  \033[0m"
# cp /Users/evan/Dropbox/dev/DevEnv/dev-env/mac/com.evan.updateMac.plist /Users/evan/Library/LaunchAgents
# launchctl load /Users/evan/Library/LaunchAgents/com.evan.updateMac.plist


#============================================================================
#                       Bash
#============================================================================
#             [sexy-bash-prompt](https://github.com/twolfson/sexy-bash-prompt)
#------------------------------------------------------------------------------
# Their one-line installation didn't work last time. I needed to do their
# manual install method.
# I might need to only do this last. Otherwise it exits the system shell and enters bash?
(cd /tmp && ([[ -d sexy-bash-prompt ]] || git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt) && cd sexy-bash-prompt && make install) && source ~/.bashrc

end_time=$(date +%s)
echo "Time elapsed: $(($end_time - $start_time)) seconds"
echo -e "\033[1;32m  ======Finished setupMac.sh======  \033[0m"
terminal-notifier -title "Finished setupMac.sh Script" \
-message "setupMac.sh has finished. You should restart the Mac after this script completes. Time elapsed: $(($end_time - $start_time)) seconds." \
-contentImage monitor-icon.icns \
-sound Glass
