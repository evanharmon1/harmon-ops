#!/bin/bash

# Script to setup a new developer environment on a Mac
# Works best, I think, if you install XCode first

echo -e "\033[1;32m  ......Starting setupMac.sh......  \033[0m"

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

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew update

brew install ${PACKAGES[@]}

brew cask install ${CASKS[@]}

brew install bash # Installs newer version of Bash side by side system Bash
chsh -s /usr/local/bin/bash

pip install --user ansible

../python/setupPython.sh
../node/setupNode.sh
../git/setupGit.sh
../vscode/setupVsCode.sh

brew upgrade

echo -e "\033[0;31m  ======Finished setupMac.sh======  \033[0m"
echo -e "\033[0;33m  *Need to add /usr/local/bin/bash to the bottom of the list at /etc/shells \033[0m"
