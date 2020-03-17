# My Aliases
alias python='python3'

alias c='clear'
alias ll='ls -lah'

alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# Docker Aliases
alias dcu='docker-compose up --build -d'  #docker-compose up
alias dcd='docker-compose down'  #docker-compose down
alias dcr='docker-compose down && docker-compose up --build -d'  #docker-compose down then docker-compose up
alias dcei='docker container exec -it ******* /bin/ash -l'  #Shell into to-be-named container
alias dclogs='docker-compose logs' #Show logs of all running containers

# My Variables
export dev="/Users/evan/Dropbox/dev" #Main dev folder
export scratch="/Users/evan/Dropbox/dev/scratch" #Scratch folder for quick prototyping
export scripts="/Users/evan/Dropbox/dev/DevEnv/dev-env/nixEnv/bashScripts" #BASH scripts on my Mac

# Scripts on *nix
#export scripts="~/bin"
# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

# GREP Customization to turn matches red like is default on monst *nix systems
export GREP_OPTIONS='--color=always'

# Terminal Customization
# old - single line: export PS1=" 👾 \[\e[34;140m\] \u@\h \[\e[35;40m\]\w \[\e[0m\]\$ "
export PS1=" 👾 \[\e[34;140m\] \u@\h \[\e[35;40m\]\w \[\e[0m\]\n✇ $ "
export CLICOLOR=1

# set EDITOR to bbedit (doesn't work)
# export EDITOR="/usr/local/bin/bbedit -w --resume"

# thefuck package https://github.com/nvbn/thefuck
eval "$(thefuck --alias)"