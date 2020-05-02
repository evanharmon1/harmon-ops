#!/bin/bash

# Script to setup a new developer environment on a Mac
# Works best, I think, if you install XCode first

# Homebrew Packages - brew install aPackage
# Need to brew install ipython and jupyter below to get their commands working on CLI - otherwise the commands weren't recognized.
PACKAGES=(
    python
    node
    watch
    thefuck
    awscli
    sqlite
    mongodb-community
    jmeter
    ipython
    jupyter
    ffmpeg
    git
    graphviz
    imagemagick
    markdown
    postgresql
    tmux
    tree
    vim
    wget
)

# Homebrew casks (GUI apps) - brew cask install aCask
CASKS=(
    visual-studio-code
    docker
    robo-3t
    java
    virtualbox
    vagrant
    github-desktop
    firefox
    postman    
    dropbox
    google-chrome
    google-drive
    iterm2
    slack
    vlc
)

echo -e "\033[1;32m  ......Starting setupMac.sh......  \033[0m"

# Ask for the administrator password upfront
sudo -v

# Install Homebrew
## Check if Homebrew is already installed
if test ! $(which brew); then
    echo Installing Homebrew...
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update

brew install ${PACKAGES[@]}

brew cask install ${CASKS[@]}

brew install bash # Installs newer version of Bash side by side the system Bash
chsh -s /usr/local/bin/bash

pip install --user ansible

../python/setupPython.sh
../node/setupNode.sh
../git/setupGit.sh
../vscode/setupVsCode.sh

# MacOS Settings
echo "Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

echo "Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "Disable Smart Quotes in system and Messages"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo "Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Showing status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "Displaying full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

brew upgrade

echo -e "\033[0;31m  ======Finished setupMac.sh======  \033[0m"
echo -e "\033[0;33m  *Need to add /usr/local/bin/bash to the bottom of the list at /etc/shells \033[0m"

support@fractureme.com