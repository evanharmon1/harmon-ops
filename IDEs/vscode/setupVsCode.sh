#!/bin/bash

# Use VS Code settings sync instead of this script.
# Script to install VS Code Extensions on a new machine
# You can generate all currently installed extensions with `code --list-extensions`
# Extensions are specified by their unique identifier on the VS Code Marketplace
# VS Code now has settings and extension syncing - https://code.visualstudio.com/docs/editor/settings-sync so I shouldn't use these scripts
# to setup new machines. I only use this file and settings.json to get my most important settings and extension in version control
# as a sort of canonical base, in case I ever want to setup VS Code from scratch again.

echo -e "\033[0;35m  ......Starting setupVsCode.sh......  \033[0m"

# Active
code --install-extension dracula-theme.theme-dracula
code --install-extension ms-azuretools.vscode-docker
code --install-extension eamodio.gitlens
code --install-extension ecmel.vscode-html-css
code --install-extension ms-toolsai.jupyter
code --install-extension ritwickdey.LiveServer
code --install-extension esbenp.prettier-vscode
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.python
code --install-extension vscode-icons-team.vscode-icons
code --install-extension Gruntfuggly.todo-tree
code --install-extension mechatroner.rainbow-csv
code --install-extension oderwat.indent-rainbow
code --install-extension johnpapa.vscode-peacock



# Inactive For now
# code --install-extension ms-vscode.vscode-typescript-tslint-plugin
# code --install-extension dbaeumer.vscode-eslint
# code --install-extension ms-mssql.mssql
# code --install-extension ms-vsliveshare.vsliveshare
# code --install-extension ms-vscode-remote.vscode-remote-extensionpack
# code --install-extension hoovercj.vscode-power-mode
# code --install-extension fabiospampinato.vscode-highlight
# code --install-extension VisualStudioExptTeam.vscodeintellicode
# code --install-extension christian-kohler.npm-intellisense
# code --install-extension christian-kohler.path-intellisense
# code --install-extension donjayamanne.githistory
# code --install-extension dsznajder.es7-react-js-snippets
# code --install-extension formulahendry.code-runner
# code --install-extension ms-vscode.powershell
# code --install-extension pranaygp.vscode-css-peek
# code --install-extension puppet.puppet-vscode
# code --install-extension wesbos.theme-cobalt2
# code --install-extension zhuangtongfa.material-theme
# code --install-extension Mit.Monokai-Polished

echo -e "\033[1;32m  ======Finished setupVsCode.sh======  \033[0m"
