#!/bin/sh

# Script to install VS Code Extensions on a new developer environment
# Remember `code --list-extensions`

echo ......Starting setupVsCode.sh......

code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension Mit.Monokai-Polished
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension christian-kohler.npm-intellisense
code --install-extension christian-kohler.path-intellisense
code --install-extension dbaeumer.vscode-eslint
code --install-extension donjayamanne.githistory
code --install-extension dracula-theme.theme-dracula
code --install-extension dsznajder.es7-react-js-snippets
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
code --install-extension fabiospampinato.vscode-highlight
code --install-extension formulahendry.code-runner
code --install-extension hoovercj.vscode-power-mode
code --install-extension mechatroner.rainbow-csv
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-mssql.mssql
code --install-extension ms-python.python
code --install-extension ms-vscode.powershell
code --install-extension ms-vscode-remote.vscode-remote-extensionpack
code --install-extension ms-vscode.vscode-typescript-tslint-plugin
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension oderwat.indent-rainbow
code --install-extension pranaygp.vscode-css-peek
code --install-extension puppet.puppet-vscode
code --install-extension ritwickdey.LiveServer
code --install-extension vscode-icons-team.vscode-icons
code --install-extension wesbos.theme-cobalt2
code --install-extension zhuangtongfa.material-theme

echo ======Finished setupVsCode.sh======