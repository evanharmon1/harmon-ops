#!/bin/sh

# Script to setup a new developer environment on a *nix computer

echo -e "\033[0;35m  ++++++Starting setupLinux.sh++++++  \033[0m"
mkdir "../../machines/${THIS_HOST}/"

#============================================================================
#                               Directories and Symbolic Links
#============================================================================
echo -e "\033[0;35m  ......Making Directories and Symbolic Links......  \033[0m"
mkdir ~/Local
mkdir ~/Local/TorrentsIncomplete
mkdir ~/.log
touch ~/.log/updateLinux.sh.log
# You can't use relative paths for symoblic links apparently. E.g. - osCongig/mac/scripts
ln -s ~/Dropbox/dev ~/
ln -s ~/dev/HarmonOps/harmon-ops/osConfig/shell/bin ~/
ln -s ~/dev/HarmonOps/harmon-ops/osConfig/linux/scripts ~/


#============================================================================
#                               Packages
#============================================================================
# Packages - apt install aPackage
# Need to apt install ipython and jupyter below to get their commands working on CLI - otherwise the commands weren't recognized.
PACKAGES=(
    software-properties-common
    ansible
    tmux
    python3
    ipython
    jupyter
    nodejs
    watch
    thefuck
    postgresql
    postgresql-contrib
    sqlite3
    mongodb
    default-jdk
    jmeter
    virtualbox
    vagrant
    ffmpeg
    git
    graphviz
    imagemagick
    markdown
    tree
    vim
    wget
    bb
    bump
    aafire
)

# Snaps - snap install aSnap
SNAPS=(
    code --classic
    robo3t-snap
)

echo -e "\033[1;32m  ......Starting setupNix.sh......  \033[0m"

# Ask for the administrator password upfront
sudo -v

apt update

apt-add-repository --yes --update ppa:ansible/ansible

apt install "${PACKAGES[@]}"

snap install "${SNAPS[@]}"


#============================================================================
#                       Bash
#============================================================================
#             [sexy-bash-prompt](https://github.com/twolfson/sexy-bash-prompt)
#------------------------------------------------------------------------------
# Their one-line installation didn't work last time. I needed to do their
# manual install method.
# TODO: Disable?
(cd /tmp && ([[ -d sexy-bash-prompt ]] || git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt) && cd sexy-bash-prompt && make install) && source ~/.bashrc


#============================================================================
#                               Zsh
#============================================================================
echo -e "\033[0;35m  ......Installing oh-my-zsh......  \033[0m"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


#============================================================================
#                               Fonts
#============================================================================
git clone https://github.com/powerline/fonts.git
./fonts/install.sh

apt upgrade

echo -e "\033[0;31m  ======Finished setupLinux.sh======  \033[0m"
