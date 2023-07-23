# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bashrc.pre.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.pre.bash"
# My custom .bashrc file

source ~/.dotfiles/.aliases
source ~/.dotfiles/.var
source ~/.dotfiles/.functions

#============================================================================
#                               Bash Terminal Customization
#============================================================================
# GREP Customization to turn matches red like is default on most *nix systems
export GREP_OPTIONS='--color=auto'

# old - single line: export PS1=" 👾 \[\e[34;140m\] \u@\h \[\e[35;40m\]\w \[\e[0m\]\$ "
export PS1=" 👾 \[\e[34;140m\] \u@\h \[\e[35;40m\]\w \[\e[0m\]\n✇ $ "
export CLICOLOR=1


#============================================================================
#                               PATH
#============================================================================
# homebrew & my dev scripts
export PATH=$PATH:/opt/homebrew/bin:/Users/evan/bin

# Scripts on *nix
#export scripts="~/bin"
# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi


#============================================================================
#                    Set default terminal editor
#============================================================================
export EDITOR="code-insiders --new-window --wait"
export VISUAL="$EDITOR"


#============================================================================
#                               Python
#============================================================================
# pyenv
PATH=$(pyenv root)/shims:$PATH


#============================================================================
#                               Ansible
#============================================================================
ANSIBLE_CONFIG=~/.ansible.cfg


#============================================================================
#                               Terraform
#============================================================================
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

#==============================================================================
#                       Sexy Bash Prompt
#==============================================================================
# Run twolfson/sexy-bash-prompt
. ~/.bash_prompt

#==============================================================================
#                       nvm
#==============================================================================
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh


#==============================================================================
#                       Fig
#==============================================================================

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bashrc.post.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.post.bash"
