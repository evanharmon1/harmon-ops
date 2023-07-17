# Open powershell as admin
# Type `Set-ExecutionPolicy RemoteSigned`
# Navigate to this script and run it in powershell
# Type `Set-ExecutionPolicy Restricted` to reset execution policy

write-output "......Starting setupWindows.ps1......"

# Download and install Chocolately
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Refresh environment variables so you can use the `choco` command
refreshenv

choco install -y python
choco install -y nodejs
choco install -y git
choco install -y vscode
choco install -y notepadplusplus
choco install -y docker-desktop
choco install -y virtualbox
choco install -y vagrant
choco install -y robo3t

# Running bash scripts on windows needs to be tested
bash ../python/setupPython.sh
bash ../node/setupNode.sh
bash ../git/setupGit.sh
bash ../vscode/setupVsCode.sh

write-output "======Finished setupWindows.ps1======"
