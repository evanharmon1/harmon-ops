# Open PowerShell as admin
# Type `Set-ExecutionPolicy Bypass -Scope Process` (applies only to current session)
# Navigate to this script and run it in powershell
# TODO: Add automation and logging

write-output "......Starting updateWindows.ps1......"

winget upgrade --all --accept-package-agreements --accept-source-agreements

# TODO: Update python, node, go, etc.

write-output "======Finished updateWindows.ps1======"
