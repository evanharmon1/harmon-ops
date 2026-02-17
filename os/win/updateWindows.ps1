# Open powershell as admin
# Type `Set-ExecutionPolicy RemoteSigned`
# Navigate to this script and run it in powershell
# Type `Set-ExecutionPolicy Restricted` to reset execution policy
# TODO: Add automation and logging

write-output "......Starting updateWindows.ps1......"

winget upgrade --all --accept-package-agreements --accept-source-agreements

# TODO: Update python, node, go, etc.

write-output "======Finished updateWindows.ps1======"
