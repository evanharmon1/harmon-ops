#!/bin/sh
# Various CLI commands to modify macOS settings
# TODO - decide what I want to pull from the superset based on what I can validate works

#============================================================================
#                               Setup
#============================================================================
echo -e "\033[0;35m  ++++++Starting configureMacSettings.sh++++++  \033[0m"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#============================================================================
#                               General UI/UX
#============================================================================
# Set computer name (as done via System Preferences → Sharing)
echo "Enter Computer Name (e.g., Evan's MacBook Pro 2021):"
read COMPUTER_NAME
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
echo "Enter Local Host Name which CAN'T HAVE SPACES (e.g., Evans-MacBook-Pro-2021):"
read LOCAL_HOST_NAME
sudo scutil --set LocalHostName "$LOCAL_HOST_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"
