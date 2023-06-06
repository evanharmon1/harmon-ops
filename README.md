# harmon-ops
My repo to help me automate setting up new machines and my developer environment, keeping track of what software to install on different machines, and various other solutions to manage my homelab and self-hosted infrastructure with IaC, etc. 

My developer environment automatically sets up my shell scripts, dotfiles, package managers, OS settings, IDE preferences, extensions, git customizations, shell aliases, functions, cli packages, programming languages, Docker containers, etc.

## OS Configuration
### Setup a Mac
1. Follow mac/CHECKLIST-MAC.md

### Setup a *nix machine (Not well-developed)
1. Follow nix/CHECKLIST-NIX.md
2. Run nix/setupNix.sh

### Setup a Windows machine (Not well-developed)
**Might Need to clone to a fresh `windows` branch from master for windows machines due to file path incompatibilities in the mac folder. You would need to delete the mac folder on that branch to avoid the errors.**
1. Follow win/CHECKLIST-WIN.md
2. win/setupWindows.ps1

### Shell Environments
On a Mac, bash, zsh, and fish dotfiles are backed up and restored with mackup command in setupMac.sh and updateMac.sh. My other global custom dotfiles like shell_vars and shell_aliases are stored in ~/.dotfiles and configured to be backed up and restored with mackup backup/restore.

### Git
This is automatically run from setupMac.sh
- git/setupGit.sh

### VS Code
This is automatically run from setupMac.sh
- IDEs/vscode/setupVsCode.sh

### Python
This is automatically run from setupMac.sh
- languages/python/setupPython.sh

### JavaScript (Not well-developed)
This is automatically run from setupMac.sh
- languages/javaScript/setupJavaScript.sh

### Java (Not well-developed)
This is automatically run from setupMac.sh
- languages/java/setupJava.sh

### Docker
- docker-compose.yml with various useful docker images
- A docker environment setup for Windows that makes developing on Windows easier due to bash, linux, containers, etc.

## My Infrastructure and Homelab
![harmonInfra.drawio.svg](infra/harmonInfra.drawio.svg)

## Sources
- [Homebrew](https://brew.sh/)
- [mas](https://github.com/mas-cli/mas)
- [mackup](https://github.com/lra/mackup)
- https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
