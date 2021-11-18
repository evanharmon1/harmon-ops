#!/bin/bash

# Script to setup a new developer environment on a Mac
# Requires following the steps listed in CHECKLIST-MAC.md
# (enabling iCloud, installing xCode via the Mac App Store)
# Requires `Brewfile` in the same directory.
# Run this script from its directory at dev-env/mac: 
# `caffeinate -disu ./setupMac.sh`
# Don't run as root or with sudo due to homebrew not wanting to run that way for security reasons.

echo -e "\033[0;35m  ......Starting setupMac.sh......  \033[0m"

# Check for and install any Apple software updates
echo -e "\033[0;35m  ......Checking for and installing any Apple software updates......  \033[0m"
softwareupdate -ia —verbose

# Install Homebrew
## Check if Homebrew is already installed
echo -e "\033[0;35m  ......Installing Homebrew if not installed......  \033[0m"
if test ! $(which brew); then
    echo Installing Homebrew...
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Installs and/or updates all listed packages in `Brewfile`
echo -e "\033[0;35m  ......Running brew bundle to install and/or update packages in Brewfile......  \033[0m"
brew bundle -v
brew cleanup

# `mackup` backs up supported app configs, settings, and dotfiles like .bash_profile to iCloud and then symlinks them back to original location
# .mackup.cfg specifies cloud storage destination. It needs to be in home directory
# mackup config needs the .mackup.cfg in the home directory and a ~/.mackup directory with
# my myCustomFiles.cfg file, but all those should be part of what mackup backup and mackup restore handles
echo -e "\033[0;35m  ......Running mackup restore to symlink existing app config, settings, and dotfiles from iCloud to their default local locations......  \033[0m"
mackup restore

# Configure Mac settings with terminal commands
echo -e "\033[0;35m  ......Configuring Mac settings with terminal commands......  \033[0m"
configureMacSettings.sh

echo -e "\033[0;35m  ......Running setupGit.sh......  \033[0m"
../git/setupGit.sh

# ../python/setupPython.sh
# ../javascript/setupJavascript.sh

echo -e "\033[1;32m  ======Finished setupMac.sh======  \033[0m"
