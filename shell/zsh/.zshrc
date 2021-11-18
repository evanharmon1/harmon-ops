# My custom .zshrc file

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

# zsh Terminal Customization
# Explanation:
# %(?.√.?%?)	if return code ? is 0, show √, else show ?%?
# %?		    exit code of previous command
# %1~		    current working dir, shortening home to ~, show only last 1 element
# %#		    # with root privileges, % otherwise
# %B %b		    start/stop bold
# %F{...}	    text (foreground) color, see table
# %f		    reset to default textcolor

PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{202}%1~%f%b %# '

# Set default terminal editor. E.g., for git, etc.
export EDITOR=bbedit
export VISUAL="$EDITOR"

# Ansible
ANSIBLE_CONFIG=~/.ansible.cfg
