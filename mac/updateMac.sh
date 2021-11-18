#!/bin/bash

# updateMac.sh
# Shell script to run periodically and/or automatically to keep Mac up to date
# Run this script from dev-env/mac: 
# `caffeinate -disu ./updateMac.sh`
# Don't run as root or with sudo due to homebrew not wanting to run that way for security reasons.

echo -e "\033[0;35m  ......Starting updateMac.sh......  \033[0m"
terminal-notifier -title updateMac.sh -subtitle "Starting updateMac.sh" -message "A periodic script that runs to update this Mac. Don't worry if it fails. It will try to run again later." -appIcon Monitor-icon.png


# Check for and install any Apple software updates
echo -e "\033[0;35m  ......Checking for and installing any Apple software updates......  \033[0m"
softwareupdate -ia —verbose

# Install Homebrew
# Check if Homebrew is already installed
if test ! $(which brew); then
	echo -e "\033[0;35m  ......Installing Homebrew......  \033[0m"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Installs and/or updates all listed packages in `Brewfile`
echo -e "\033[0;35m  ......Running brew bundle to install and/or update packages in Brewfile......  \033[0m"
brew bundle -v
brew cleanup

# `mackup` backs up supported app configs, settings, and dotfiles like .bash_profile to iCloud and then symlinks them back to original location
echo -e "\033[0;35m  ......Running mackup backup to symlink any new dotfiles, config files, etc. to iCloud......  \033[0m"
# TODO: automatic yes?
mackup backup

echo -e "\033[1;32m  ======Finished updateMac.sh======  \033[0m"