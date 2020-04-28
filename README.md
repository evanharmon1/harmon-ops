# dev-env
A repo I use to keep track of the various CLI packages and libraries I like to use as well as BASH customizations, scripts, python packages, node modules, git customizations, and a docker-compose file with docker images I find useful for my developer environment.

## BASH Packages
nix/setupNix.sh
mac/setupMac.sh

## Python Packages
python/setupPython.sh

## Node Modules
- tldr
	- https://github.com/tldr-pages/tldr

## Mac
- Homebrew
- iTerm

## Windows
- WSL
- Powershell
- cmd shell
- Git Bash
**Need to clone `windows` branch on windows machines due to file path incompatibilities in the mac folder. The `windows` branch just omits the mac folder.**

### Docker Developer Environment on Windows
- In order to get the dockerVol shared/mounted folder working inside running docker containers, Docker settings need to share the local C drive. Sometimes a restart is required. Sometimes you need to make sure to confirm any pop up windows about sharing volumes. I think I solved some problems by putting my docker-compose and dockerVol at the C:/ root level on Windows systems.