# Open PowerShell as admin
# Type `Set-ExecutionPolicy Bypass -Scope Process` (applies only to current session)
# Navigate to this script and run it in powershell

write-output "......Starting setupWindows.ps1......"

#==============================================================================
#                       WinGet Configuration
#==============================================================================
# Apply Windows settings via DSC (dark mode, dev mode, taskbar, explorer)
write-output "--- Applying Windows settings via DSC ---"
winget configure --file "$PSScriptRoot\winget\settings.dsc.yaml" --accept-configuration-agreements

#==============================================================================
#                       Package Installation
#==============================================================================
# Unavailable on WinGet (install manually): TextExpander, AirServer, Ventoy

write-output "--- Installing development packages ---"
winget import --import-file "$PSScriptRoot\winget\development.json" --accept-package-agreements --accept-source-agreements

write-output "--- Installing productivity packages ---"
winget import --import-file "$PSScriptRoot\winget\productivity.json" --accept-package-agreements --accept-source-agreements

write-output "--- Installing gaming packages ---"
winget import --import-file "$PSScriptRoot\winget\gaming.json" --accept-package-agreements --accept-source-agreements

#==============================================================================
#                       Machine-Specific Notes
#==============================================================================
# $machina    - 
# $contraption - all three: development, productivity, gaming
# $tars - all three: development, productivity, gaming

write-output "======Finished setupWindows.ps1======"
