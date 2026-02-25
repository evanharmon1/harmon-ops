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
# Create Shell COM object once
$shell = New-Object -ComObject Shell.Application

# Quick Access shell namespace
$quickAccess = $shell.Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}")

# Collect currently pinned paths
$pinnedPaths = $quickAccess.Items() |
    Where-Object { $_.Path } |
    ForEach-Object { $_.Path }

# Folders we want pinned
$foldersToPin = @(
    $env:USERPROFILE
    (Join-Path $env:USERPROFILE "git")
)

foreach ($folder in $foldersToPin) {
    if (Test-Path $folder -PathType Container) {
        if ($pinnedPaths -notcontains $folder) {
            $shell.Namespace($folder).Self.InvokeVerb("pintohome")
        }
    }
}

# Restart Explorer to apply theme/taskbar changes
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

#==============================================================================
#                       Package Installation
#==============================================================================

$development = @(
	"Microsoft.WSL"
	"Canonical.Ubuntu.2404"
	"Microsoft.VisualStudioCode"
	"Microsoft.VisualStudioCode.Insiders"
	"Docker.DockerDesktop"
	"GitHub.GitHubDesktop"
	"Microsoft.WindowsTerminal"
	"wez.wezterm"
	"Microsoft.PowerShell"
	"Axosoft.GitKraken"
	"Bruno.Bruno"
	"Anthropic.ClaudeCode"
	"OpenAI.Codex"
)

$productivity = @(
	"AgileBits.1Password"
	"Dropbox.Dropbox"
	"Google.GoogleDrive"
	"Google.Chrome"
	"Mozilla.Firefox"
	"VideoLAN.VLC"
	"7zip.7zip"
	"SlackTechnologies.Slack"
	"OpenWhisperSystems.Signal"
	"MullvadVPN.MullvadVPN"
	"Tailscale.Tailscale"
	"uvncbvba.UltraVNC"
	"Ditto.Ditto"
	"Transmission.Transmission"
	"NirSoft.NirCmd"
	"IrfanSkiljan.IrfanView"
	"GIMP.GIMP"
	"HandBrake.HandBrake"
	"WinDirStat.WinDirStat"
	"Balena.Etcher"
	"Rufus.Rufus"
	"Obsidian.Obsidian"
	"Microsoft.PowerToys"
	"voidtools.Everything"
	"Notepad++.Notepad++"
	"Ventoy.Ventoy"
	"TextExpander.TextExpander"
	"AppDynamic.AirServer"
	"Ookla.Speedtest"
	"REALiX.HWiNFO"
	"ALCPU.CoreTemp"
	"CPUID.CPU-Z"
	"TechPowerUp.GPU-Z"
)

$localai = @(
	"Ollama.Ollama"
	"ElementLabs.LMStudio"
)

$media = @(
	"AmazonVideo.PrimeVideo"
	"Plex.Plex"
)

$homelab = @(
	"Netdata.Netdata"
	"WireGuard.WireGuard"
	"WinSCP.WinSCP"
	"angryziber.AngryIPScanner"
	"Microsoft.Sysinternals"
	"WiresharkFoundation.Wireshark"
	"FoldingAtHome.FoldingAtHome"
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
	"PrimateLabs.Geekbench.6"
	"Unigine.HeavenBenchmark"
	"Unigine.ValleyBenchmark"
	"Unigine.SuperpositionBenchmark"
	"LizardByte.Sunshine"
	"MoonlightGameStreamingProject.Moonlight"
)

# Manual installs (no winget ID or better from official source):
# Nvidia App
# MSI Afterburner - GPU monitoring/OC (no winget ID)
# CUDA Toolkit - via NVIDIA (if doing GPU AI work)
# ComfyUI / Automatic1111 - image gen (Python-based)
# AMD Software Adrenalin - if using RX 9070 XT (use AMD's installer)
# Raycast - Windows version in beta
# Willow Voice
# Claude
# Perplexity
# ChatGPT
# Pluto TV
# Tubi
# Apple TV
# Apple Music
# Peacock
# Disney+
# Netflix
# HBO
# Paramount+

#==============================================================================
#                       Machine-Specific Notes
#==============================================================================
# $machina     -
# $contraption - development, productivity, gaming, localai, homelab, media
# $tars        - development, productivity, gaming, localai, homelab, media

$packages = $development + $productivity + $gaming + $localai + $homelab + $media

write-output "--- Installing $($packages.Count) packages ---"
foreach ($package in $packages) {
	winget install --exact --id $package --accept-package-agreements --accept-source-agreements
}

write-output "======Finished setupWindows.ps1======"
