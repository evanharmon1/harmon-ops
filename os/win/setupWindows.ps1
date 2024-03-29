# Open powershell as admin
# Type `Set-ExecutionPolicy RemoteSigned`
# Navigate to this script and run it in powershell
# Type `Set-ExecutionPolicy Restricted` to reset execution policy

write-output "......Starting setupWindows.ps1......"

# Download and install Chocolately
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Refresh environment variables so you can use the `choco` command
refreshenv

#==============================================================================
#                       Packages
#==============================================================================
#             Superset of Potential Packages to install
#------------------------------------------------------------------------------
# notepadplusplus, docker-desktop, virtualbox, vagrant, robo3t

#             Packages to Install
#------------------------------------------------------------------------------
$packages = "wsl", "wsl-ubuntu-2204", "python", "nodejs", "vscode", "vscode-insiders", "docker-desktop", "textexpander", "1password", "dropbox", "googledrive", "googlechrome", "firefox", "geforce-experience", "transmission", "vlc", "airserver", "razer-synapse-3", "steam", "nircmd", "etcher", "rufus", "ventoy", "geekbench", "hwinfo", "slack", "discord", "twitch", "signal", "mullvad-app", "tailscale", "fah", "valley-benchmark", "heaven-benchmark", "leagueoflegends", "goggalaxy", "epicgameslauncher", "ea-app", "amazongames", "playnite", "7zip", "windirstat", "coretemp", "irfanview", "gimp", "handbrake", "ccleaner"

$machina = "wsl", "wsl-ubuntu-2204", "python", "nodejs", "vscode", "vscode-insiders", "docker-desktop", "textexpander", "1password", "dropbox", "googledrive", "googlechrome", "firefox", "geforce-experience", "transmission", "vlc", "airserver", "razer-synapse-3", "steam", "nircmd", "etcher", "rufus", "ventoy", "geekbench", "hwinfo", "slack", "discord", "twitch", "signal", "mullvad-app", "tailscale", "fah", "valley-benchmark", "heaven-benchmark", "leagueoflegends", "goggalaxy", "epicgameslauncher", "ea-app", "amazongames", "playnite", "7zip", "windirstat", "coretemp", "irfanview", "gimp", "handbrake", "ccleaner"

$contraption = ""

foreach ($package in $packages){
	choco install -y $package
}

# TODO: Running bash scripts on windows needs to be tested
bash ../python/setupPython.sh
bash ../node/setupNode.sh
bash ../git/setupGit.sh

write-output "======Finished setupWindows.ps1======"
