#!/bin/sh

#==============================================================================
#                       Bootstrap Mac
#==============================================================================
# Author: Evan Harmon
# First script to run to bootstrap the automated setup of a new Mac
# Follow the prerequisite steps listed in CHECKLIST-MAC.md
# Run this script from the repo's os/mac directory:
# To run unattended: `caffeinate -disu ./bootstrapMac.sh

echo -e "\033[0;35m  ++++++Starting bootstrapMac.sh - $(date) "+%FT%T"++++++  \033[0m"
start_time=$(date +%s)


#==============================================================================
#                       Set Hostname
#==============================================================================
read -p 'Enter friendly Computer Name (For Example - "Evans MacBook Pro"):' computerName # Friendly name
scutil --set ComputerName "$computerName"
echo "New ComputerName:"
scutil --get ComputerName

read -p 'Enter Host Name (For Example - "EvansMacBookPro"): ' hostName # Use FQDN if needed. Otherwise just a simple MacServer
scutil --set HostName "$hostName"
echo "New HostName:"
scutil --get HostName

read -p 'Bonjour Name (For Example - "EvansMacBookPro". .local is added automatically): ' bonjourName #.local is appended automatically
scutil --set LocalHostName "$bonjourName"
echo "New LocalHostName:"
scutil --get LocalHostName

dscacheutil -flushcache


#==============================================================================
#                       Install Homebrew
#==============================================================================
# Homebrew also installs git from the Xcode CLI tools):
# Be sure to run the 2 commands that homebrew tells you to run to add brew to your PATH.
# If you want to manually install Xcode CLI tools and git:
# `xcode-select --install`
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


#==============================================================================
#                       Copy Brewfile and CHECKLIST for this machine
#==============================================================================
mkdir "../../infra/${hostName}/"
cp ../brew/BrewfileSuperset ~/Brewfile
cp CHECKLIST-MAC.md "../../infra/${hostName}/"


#==============================================================================
#                       Apple Software Updates
#==============================================================================
echo -e "\033[0;35m  ......Checking for and installing any Apple software updates......  \033[0m"
# Mac system software and App Store updates and restart if needed
softwareupdate --install --all

end_time=$(date +%s)
echo "Time elapsed: $(($end_time - $start_time)) seconds"
echo -e "\033[1;32m  ======Finished bootstrapMac.sh======  \033[0m"
