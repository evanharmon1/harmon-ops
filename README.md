# dev-env
A git repo I maintain to help me bootstrap new computers with a developer environment customized to my liking with shell scripts, dotfiles, package managers, OS settings, IDE preferences, extensions, git customizations, shell aliases, functions, cli packages, programming languages, Docker containers, etc. It also helps me keep track of and document my evolving setup in an Infrastructure as Code (IaC) style. All scripts should be idempotent.

## Setup a Mac
1. Follow mac/CHECKLIST-MAC.md
2. Run mac/setupMac.sh
3. Periodically run mac/updateMac.sh
	- Shell script to run periodically and/or automatically to keep Mac's software and CLI packages up to date
	
Uses homebrew and mackup for package management and dotfile backup/restore

## Setup a *nix machine (Not well-developed)
1. Follow nix/CHECKLIST-NIX.md
2. Run nix/setupNix.sh

## Setup a Windows machine (Not well-developed)
**Need to clone `windows` branch on windows machines due to file path incompatibilities in the mac folder. The `windows` branch just omits the mac folder.**
1. Follow win/CHECKLIST-WIN.md
2. win/setupWindows.ps1

## Shell Environments
On a Mac, bash, zsh, fish, shell_vars, and shell_aliases dotfiles are backed up and restored with mackup command in setupMac.sh and updateMac.sh

## Git

This is automatically run from setupMac.sh
- git/setupGit.sh

## VS Code
This is automatically run from setupMac.sh
- IDEs/vscode/setupVsCode.sh

## Python
This is automatically run from setupMac.sh
- languages/python/setupPython.sh

## JavaScript (Not well-developed)
This is automatically run from setupMac.sh
- languages/javaScript/setupJavaScript.sh

## Java (Not well-developed)
This is automatically run from setupMac.sh
- languages/java/setupJava.sh

## Docker
- docker-compose.yml with various useful docker images
- A docker environment setup for Windows that makes developing on Windows easier due to bash, linux, containers, etc.

## Sources
- homebrew
- mas
- mackup
- https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
