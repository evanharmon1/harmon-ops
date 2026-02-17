# Open PowerShell as admin
# Type `Set-ExecutionPolicy Bypass -Scope Process` (applies only to current session)
# Navigate to this script and run it in powershell

write-output "......Starting setupWindows.ps1......"

#==============================================================================
#                       Windows Settings
#==============================================================================
write-output "--- Applying Windows settings ---"

# Dark mode (app + system theme)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0

# Developer mode
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# Taskbar: align left, hide search box
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0

# Explorer: show file extensions and hidden files
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1

# Restart Explorer to apply theme/taskbar changes
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

#==============================================================================
#                       Package Installation
#==============================================================================
# Unavailable on WinGet (install manually): TextExpander, AirServer, Ventoy, Nvidia App, Twitch

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
