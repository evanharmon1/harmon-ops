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

# Time zone
Set-TimeZone -Id "Central Standard Time"

# Pin folders to Quick Access
$shell = New-Object -ComObject Shell.Application
$shell.Namespace("$env:USERPROFILE").Self.InvokeVerb("pintohome")
$shell.Namespace("$env:USERPROFILE\git").Self.InvokeVerb("pintohome")

# Restart Explorer to apply theme/taskbar changes
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

#==============================================================================
#                       Package Installation
#==============================================================================
# Unavailable on WinGet (install manually): TextExpander, AirServer, Ventoy, Nvidia App, Twitch

$development = @(
	"Microsoft.WSL"
	"Canonical.Ubuntu.2204"
	"Python.Python.3.13"
	"OpenJS.NodeJS"
	"Microsoft.VisualStudioCode"
	"Microsoft.VisualStudioCode.Insiders"
	"Docker.DockerDesktop"
	"7zip.7zip"
	"Git.Git"
)

$productivity = @(
	"AgileBits.1Password"
	"Dropbox.Dropbox"
	"Google.GoogleDrive"
	"Google.Chrome"
	"Mozilla.Firefox"
	"VideoLAN.VLC"
	"SlackTechnologies.Slack"
	"OpenWhisperSystems.Signal"
	"MullvadVPN.MullvadVPN"
	"Tailscale.Tailscale"
	"Transmission.Transmission"
	"NirSoft.NirCmd"
	"IrfanSkiljan.IrfanView"
	"GIMP.GIMP"
	"HandBrake.HandBrake"
	"Piriform.CCleaner"
	"WinDirStat.WinDirStat"
	"Balena.Etcher"
	"Rufus.Rufus"
)

$gaming = @(
	"Valve.Steam"
	"RazerInc.RazerInstaller"
	"Discord.Discord"
	"GOG.Galaxy"
	"EpicGames.EpicGamesLauncher"
	"ElectronicArts.EADesktop"
	"Amazon.Games"
	"Playnite.Playnite"
	"RiotGames.LeagueOfLegends.NA"
	"REALiX.HWiNFO"
	"ALCPU.CoreTemp"
	"PrimateLabs.Geekbench.6"
	"FoldingAtHome.FoldingAtHome"
	"Unigine.ValleyBenchmark"
	"Unigine.HeavenBenchmark"
	"LizardByte.Sunshine"
	"MoonlightGameStreamingProject.Moonlight"
)

#==============================================================================
#                       Machine-Specific Notes
#==============================================================================
# $machina     -
# $contraption - development, productivity, gaming
# $tars        - development, productivity, gaming

$packages = $development + $productivity + $gaming

write-output "--- Installing $($packages.Count) packages ---"
foreach ($package in $packages) {
	winget install --exact --id $package --accept-package-agreements --accept-source-agreements
}

write-output "======Finished setupWindows.ps1======"
