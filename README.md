# dev-env
A repo I use to keep track of the various CLI packages and libraries I like to use as well as Bash customizations, scripts, python packages, node modules, git customizations, VS Code extensions, and a docker-compose file with docker images I find useful for my developer environment. All scripts should be idempotent.

## Mac
mac/setupMac.sh

- Homebrew
- iTerm

## *nix
nix/setupNix.sh

## Windows
win/setupWindows.ps1

- WSL2
- Powershell
- cmd shell
- Git Bash
- Windows Terminal

**Need to clone `windows` branch on windows machines due to file path incompatibilities in the mac folder. The `windows` branch just omits the mac folder.**

## Bash
.bash_profile

### Bash Packages
nix/setupNix.sh
mac/setupMac.sh

## Python Packages
python/setupPython.sh

## Node Modules
node/setupNode.sh

## Git
git/setupGit.sh

## VS Code
vscode/setupVsCode.sh

## Docker
docker-compose.yml

- Issue: I think I should try to get this working with the dockerVol in this repo. Might need to modify docker-compose.yml to find the repo's dockerVol.

### Docker Developer Environment on Windows
- In order to get the dockerVol shared/mounted folder working inside running docker containers, Docker settings need to share the local C drive. Sometimes a restart is required. Sometimes you need to make sure to confirm any pop up windows about sharing volumes. I think I solved some problems by putting my docker-compose and dockerVol at the C:/ root level on Windows systems.

## Tasks
- Tmux config
- Zsh, fish customizations
- IDE settings? VS Code, IntelliJ, etc.
- Other apps
	- mongo, sqlite, postgres, robo3t, mysql workbench, mysql, mamp, xamp
- Publish my VS Code extension and add to setupVsCode.sh
- Vagrant?
- Terraform?
- Ansible?
- Puppet?
- Ruby?
- Java?
- Go?
- C#?
- Sensu?
- Grafana?
- Artifactory?