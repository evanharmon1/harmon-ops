#!/bin/bash

# Script to setup a new developer environment on a Mac
# Requires following the steps listed in CHECKLIST-MAC.md
# (enabling iCloud, installing Dropbox, installing xCode via the Mac App Store)
# Requires `Brewfile` in the same directory.
# Run this script from its directory at dev-env/mac: 
# `caffeinate -disu ./setupMac.sh`
# Don't run as root or with sudo due to homebrew not wanting to run that way for security reasons.

echo -e "\033[0;35m  ......Starting setupMac.sh......  \033[0m"

#============================================================================
#                               Apple Software Updates
#============================================================================
echo -e "\033[0;35m  ......Checking for and installing any Apple software updates......  \033[0m"
softwareupdate -ia —verbose


#============================================================================
#                               Homebrew
#============================================================================
# TODO: Didn't work clearnly last time - probably just need to install Homebrew manually first.
echo -e "\033[0;35m  ......Installing Homebrew if not installed......  \033[0m"
if test ! $(which brew); then
    echo Homebrew not installed. Installing Homebrew now...
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    # Add 'brew' command to zsh - didn't work last time 11-28-2021
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/evan/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo -e "\033[0;35m  ......Running brew bundle to install and/or update packages in Brewfile......  \033[0m"
brew bundle -v
brew cleanup


#============================================================================
#                               Directories and Symbolic Links
#============================================================================
echo -e "\033[0;35m  ......Making Directories and Symbolic Links......  \033[0m"
mkdir /Users/evan/bin
mkdir /Users/evan/Local
mkdir /Users/evan/Local/Banktivity
mkdir /Users/evan/Local/TorrentsIncomplete
ln -s /Users/evan/Dropbox/dev /Users/evan
ln -s /Users/evan/Dropbox/dev/DevScripts/dev-scripts /Users/evan/bin


#============================================================================
#                               mackup for dotfiles
#============================================================================
# `mackup` backs up supported app configs, settings, and dotfiles like .bash_profile to iCloud and then symlinks them back to original location
# .mackup.cfg specifies cloud storage destination. It needs to be in home directory
# mackup config needs the .mackup.cfg in the home directory and a ~/.mackup directory with
# the myDotFiles.cfg file, but all those should be part of what mackup backup and mackup restore handles
echo -e "\033[0;35m  ......Running mackup restore to symlink existing app config, settings, and dotfiles from iCloud to their default local locations......  \033[0m"
ln -s /Users/evan/Library/"Mobile Documents"/com~apple~CloudDocs/Mackup/.mackup.cfg /Users/evan
mackup restore


#============================================================================
#                               macOS Settings via Terminal
#============================================================================
echo -e "\033[0;35m  ......Configuring Mac settings with terminal commands......  \033[0m"
./configureMacSettings.sh


#============================================================================
#                               Zsh
#============================================================================
echo -e "\033[0;35m  ......Installing oh-my-zsh......  \033[0m"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


#============================================================================
#                               fish
#============================================================================
# TODO: tide and/or oh-my-fish


#============================================================================
#                               Python
#============================================================================
# ../python/setupPython.sh


#============================================================================
#                               JavaScript
#============================================================================
# ../javascript/setupJavascript.sh


#============================================================================
#                               VS Code
#============================================================================
echo -e "\033[0;35m  ......Installing Fonts......  \033[0m"
../IDEs/vscode/setupVsCode.sh


#============================================================================
#                               Fonts
#============================================================================
git clone https://github.com/powerline/fonts.git
./fonts/install.sh

#============================================================================
#                               Apple launchd Service for updateMac.sh
#============================================================================
# Setup updateMac.sh script as a launchd/launchctl service to run automatically once a week and at startup
echo -e "\033[0;35m  ......Setting up updateMac.sh as an Apple launchd service to run automatically......  \033[0m"
cp /Users/evan/Dropbox/dev/DevEnv/dev-env/mac/com.evan.updateMac.plist /Users/evan/Library/LaunchAgents
launchctl load /Users/evan/Library/LaunchAgents/com.evan.updateMac.plist


echo -e "\033[1;32m  ======Finished setupMac.sh======  \033[0m"
terminal-notifier -title "Finished setupMac.sh Script" \
-message "The initial setup script that sets up this Mac has finished. You should restart the Mac after this script completes." \
-contentImage monitor-icon.icns \
-sound Glass
