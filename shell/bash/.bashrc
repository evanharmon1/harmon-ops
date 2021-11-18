# My custom .bashrc file

# source aliases file
source ~/.shell_aliases

# source vars file
source ~/.shell_vars

# Scripts on *nix
#export scripts="~/bin"
# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

# GREP Customization to turn matches red like is default on most *nix systems
export GREP_OPTIONS='--color=auto'

# Terminal Customization
# old - single line: export PS1=" 👾 \[\e[34;140m\] \u@\h \[\e[35;40m\]\w \[\e[0m\]\$ "
export PS1=" 👾 \[\e[34;140m\] \u@\h \[\e[35;40m\]\w \[\e[0m\]\n✇ $ "
export CLICOLOR=1

# Set default terminal editor. E.g., for git, etc.
export EDITOR=bbedit
export VISUAL="$EDITOR"

# Ansible
ANSIBLE_CONFIG=~/.ansible.cfg
