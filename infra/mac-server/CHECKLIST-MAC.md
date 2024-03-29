# CHECKLIST-MAC.md
Checklist for setting up a new Mac

## Create **machine-specific folder** in infra/{machineName}
(for machine-specific Brewfile, checklist, and any other files, scripts, etc.)
- [x] Copy this checklist file to that folder to keep track of config process (open in Typora)

## **Install macOS** from scratch
- [x] Erase your Mac with Erase Assistant:
    - [x] https://support.apple.com/guide/mac-help/erase-and-reinstall-macos-mh27903/mac
- [x] If Intel Mac before T2 Security Chip:
    - [x] If you need to create Bootable media for the macOS version you want to install:
        - https://support.apple.com/en-us/HT201372
- [x] Full Name: Evan Harmon
- [x] Account Name: evan
	- [x] Recover password from iCloud option: no
- [x] FindMy: yes
- [x] Location Services: yes
- [x] Analytics: no
- [x] Screentime: yes (server: no)
- [x] Siri: yes (server: no)
- [x] Improve Siri: no
- [x] FileVault encryption: yes
	- [x] Recover passwoed from iCloud option: no
	- [ ] Store FileVault Encryption recovery key in password manager
- [x] Apple Pay: yes (server: no)
- [x] Appearance: Auto (server: dark)

## Sign into **iCloud** and enable everything to start syncing
- [x] All on, including keychain
- [x] Turn on sync desktop and documents
- [x] Choose profile pic
- [x] Optimize Mac Storage: yes, if OS drive is small, no if you want to replicate iCloud to the machine.
- [x] private relay - yes

## Download **Dropbox** and start syncing so I can get my Dropbox dev folder with **dev-env** repo and setupMac.sh
(Alternatively, skip Dropbox installation and git clone the dev-env repo.)
- [ ] Verify when deleting off of Dropbox: No
- [ ] Share screenshots and recordings using Dropbox: No (Use CleanShot X)
- [ ] Upload Photos: No
- [ ] Ask to backup connected external drives: No
- [x] Choose Folders to sync:
- [x] Default for new files -online-only
- [ ] Smart sync: No

## Authenticate **Mac App Store** & download Amphetamine
- [x] Install Amphetamine via Mac App Store

## Install **Xcode CLI tools**
(Xcode CLI Tools includes git, but homebrew will later install a newer git version.)
- [x] `xcode-select --install` (Install Xcode CLI Tools)

## Install **Homebrew**, update macOS and App Store apps, & clean **reboot**
- [x] Install homebrew (which also installs git from Xcode?):
  ` /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
    - [x] And run the 2 commands that homebrew tells you to run to add brew to your PATH.
- [x] Apple Software Update - macOS & App Store
- [x] clean reboot

## Create **machine-specific IaC Brewfile** in infra/{machineName} folder
- [ ] Duplicate the `BrewfileSuperSet` file, name it `Brewfile`, and put it in `infra/{machineName}` folder
- [ ] Modify that Brewfile based on the machine you're configuring (delete and add any apps/packages you want installed)
- [ ] Push that Brewfile to the repo in `infra/{machineName}` folder.
- [ ] Modify `setupMac.sh` to have `brew bundle` point to that machine-specific `Brewfile`.

## Run **setupMac.sh** from its directory at dev-env/mac
- [ ] Verify the `setupMac.sh`, `configureMacSettings.sh`, and `updateMac.sh` are going to do what you want for this machine.
    (E.g., Mackup functionality for dotfiles, autoupdate functionality, Mac settings via CLI, etc.)
    (Modify these files but don't commit them to the repo unless they are relevant for all machines.)
    - [ ] Check what dotfiles from Mackup in iCloud will be linked over to the local machine and delete any from iCloud that are not wanted.
    - [ ] Make a backup of the Mackup directory in iCloud (In case the mackup restore command messes up)
    - [ ] Double check that any dotfiles you don't want synced to Mackup/iCloud are excluded in the `~/evan/.mackup.cfg` file. (E.g., sensitive info like ssh.)
- [ ] Turn on Amphetamine for at least a few hours (although the `caffeinate` command should keep the Mac awake).
- [ ] `caffeinate -disu ./setupMac.sh`
    - [ ] Usually needs a few Mac password prompts, so check it periodically
    - [ ] After sexy-bash-prompt install, you need to type exit to get out of the bash env that loads so the setupMac.sh script continues.

## Connect **Peripherals**
- [ ] Keyboards
- [ ] Mice
- [ ] Printers
  - [ ] Test print

## Configure remaining Apple **Manual Settings** not set in `configureMacSettings.sh`
### Storage Management.app
- [ ] Store in iCloud
	- [ ] Desktop and Documents
	- [ ] Photos
- [ ] Empty Trash automatically

### Settings > General
- [ ] Appearance - Auto
- [ ] Accent Color - Multicolor
- [ ] Scroll bars - automatic, and jump to position
- [ ] Recent items - 50
- [ ] close windows when quitting an app - no

### Settings > Desktop & Screensaver
- [ ] Screensaver
	- [ ] Start after 20 minutes

### Settings > Dock & Menu Bar
- [ ] Double click window title bar to zoom
- [ ] Battery - show percentage, in menubar and control center
- [ ] Spotlight: Show in menubar - no
- [ ] Siri: Show in menubar - no
- [ ] Time Machine: Show in menubar - yes, if doing Time Machine
- [ ] Clock > Date: Show day of week, show date, show am/pm
- [ ] Add Downloads folder to Dock
  - [ ] Sort by: Date Added
  - [ ] Display as: Folder
  - [ ] View Content as: Grid

### Settings > Mission Control & Spaces
- [ ] Auto rearrange spaces - no

### Settings > Notifications & Focus
- [ ] Allow notifications
	- [ ] When display is sleeping - no
	- [ ] When display is locked - yes
	- [ ] When mirroring or sharing display - no

### Settings > Internet Accounts
- [ ] Google
	- [ ] Google Mail only, not calendar, etc.

### Settings > Wallet & Apple Pay
- [ ] Setup cards, etc.

### Settings > Users & Groups
(In general, it's easier to just have most people be admins. It's kind of annoying otherwise where they can't even restart the computer, etc.)
- [ ] Enable guest account if visitors might want to use it.

### Settings > Accessibility
- [ ] Zoom - Use scroll gesture with modifier keys to zoom - ctrl
- [ ] Pointer Control - Mouse & Trackpad - Spring loaded delay - second shortest
- [ ] Hot Corners?

### Settings > Extensions & Services
- [ ] Enable pretty much everything
- [ ] Create Open in... extensions with Automator
    [Open anything in VS Code using a MacOS quick action](https://www.jimbobbennett.io/open-anything-in-vs-code-using-a-macos-quick-action/)
    - [ ] Open in VS Code
        - Workflow receives current files or folders in any application
        - Run Shell Script
        - Pass input as arguments
        - `open -n -b "com.microsoft.VSCode" --args "$*" `
    - [ ] Open in VS Code Insider's
        - Workflow receives current files or folders in any application
        - Run Shell Script
        - Pass input as arguments
        - `open -n -b "com.visualstudio.code.oss" --args "$*" `
- [ ] Install Brett Terpstra's Tools
    - [ ] [Markdown Service Tools - BrettTerpstra.com](https://brettterpstra.com/projects/markdown-service-tools/)
    - [ ] [SearchLink - BrettTerpstra.com](https://brettterpstra.com/projects/searchlink/)
    - [ ] [URL Preview - BrettTerpstra.com](https://brettterpstra.com/projects/url-preview/)
    - [ ] Gather?
    - [ ] Via homebrew now?

### Settings > Security & Privacy
- [ ] Require password 5 seconds after sleep or screen saver
- [ ] Use Apple Watch to unlock Mac
- [ ] Filevault on

### Settings > Software Update
- [ ] Turn on everything automatic

### Settings > Network
- [ ] Turn off auto join for alternate networks. Otherwise it will connect to those sometimes.
- [ ] Drag to arrange networks in order of preference.
- [ ] Show Wifi in menubar

### Settings > Bluetooth
- [ ] Show Bluetooth in menubar

### Settings > Sound
- [ ] Show Sound in menubar - always
- [ ] Play feedback when volume is changed - no

### Settings > Touch ID
- [ ] Enable everything
- [ ] Add other fingers

### Settings > Keyboard
- [ ] Set caps lock to Escape Key - need to do this for any attached keyboard via the dropdown
- [ ] Keyboard Key Repeat and Delay Until Repeat to highest
- [ ] Text Expansion
	- [ ] Try to keep the main ones in sync with TextExpander
		- Like “zhome” etc.
		- I think it works ok for both to be active
		- The Apple ones will work in any application in iOS e.g.
- [ ] Enable Dictation
- [ ] Show input menu in menubar

### Settings > Trackpad
- [ ] No tap to click?
- [ ] Click - light
- [ ] Tracking speed - third to fastest
- [ ] Swipe between full screen apps - 4 fingers
- [ ] Disable Mission Control swipe
- [ ] Disable App Expose swipe
- [ ] Disable Launchpad swipe

### Settings > Display
- [ ] Automatically adjust brightness
- [ ] True Tone
- [ ] Refresh Rate - Pro Motion
- [ ] Night Shift?

### Settings > Printer
- [ ] Add printers

### Settings > Battery
- [ ] Prevent computer from sleeping auto when display is off - yes.
- [ ] Wake for network always on
- [ ] Hard drives to sleep - not sure, prob not for servers, yes otherwise?
- [ ] Turn display off - 45 minutes on power, 30 min on battery
- [ ] Set UPS shutdown thresholds if using a UPS
    - [ ] Turn off when 8 minutes remaining
    - [ ] Turn off when 5% remaining
    (Safer with both on - more redundant with multiple thresholds and the 8 min should usually give a little longer to make sure the Mac has enough time to complete shutdown.)

### Settings > Date & Time
- [ ] Set date and time auto
- [ ] Set timezone automatically
- [ ] Show day of week and date in menu bar

### Settings > Sharing
- [ ] In general keep everything off unless you need to have it on. E.g. if you setup Screens or need to share files temporarily. But then should probably turn it off.
- [ ] AirPlay Receiver - yes
- [ ] Content caching - on for servers, no for laptops

### Finder
// todo
- [ ] Add ~/Dropbox/Devices/Downloads to Finder sidebar and remove system Downloads folder

### Safari
// todo
- [ ] Set downloads to `~/Dropbox/Devices/Downloads`

### Notification Center/Sidebar Thing
- [ ] Tomorrow
- [ ] Weather - Current, Hill City
- [ ] Batteries (fadel.io)
- [ ] Deliveries

### Messages
- [ ] iMessages in iCloud: enable in iMessages app
- [ ] Enable photo and sharing thing?

## Download Remaining 3rd Party Apps that Aren't Available in Homebrew Repos
- [ ] [Markdown Service Tools - BrettTerpstra.com](https://brettterpstra.com/projects/markdown-service-tools/)
- [ ] [Aeon Timeline](https://timeline.app/download/)
- [ ] [Textsniper](https://textsniper.app/api/downloads/mac-latest)
- [ ] [Squash](https://www.realmacsoftware.com/download/squash/)
- [ ] [Textsoap](https://textsoap.com/mac/)
- [ ] [Amphetamine Enhancer](https://github.com/x74353/Amphetamine-Enhancer/raw/master/Releases/Current/Amphetamine%20Enhancer.dmg)
- [ ] [Copy'em Helper](https://apprywhere.com/ce-helper.html)
- [ ] MacGPT
- [ ] MacBing
- [ ] Readwise and Reader and extension

### Archived (Don't Install or reevaluate)
- [ ] [MailSuite](https://smallcubed.com/)

## Configure Remaining App Settings (todo)
### Open all applications:
- [ ] register licenses, if necessary
- [ ] login/setup sync, if necessary
- [ ] accept/deny notifiactions
- [ ] start at login, if necessary
- [ ] Install browser extensions, if necessary

### Make webapps local with Fluid.app or Unite.app
- [ ] Google Voice and add to Dock after Slack
- [ ] Google Meet and add to dock after Google Voice
- [ ] Jira (work)
- [ ] Confluence (work)

### Apple Mail
- [ ] Set Mailbox behaviors (archive, draft folders, etc.)

### iTerm
- Handled by Mackup

### Warp
- Handled by Mackup?

### VS Code
- [ ] Install command line tools

### VS Code Insider's
- [ ] Install command line tools

### TextMate
- [ ] Install command line tools

### Nova
- [ ] Install command line tools

### BBedit
- [ ] Install command line tools

### 1Password
- [ ] Safari Extension
- [ ] FireFox Extension
- [ ] Google Chrome Extension
- [ ] Menubar App
- [ ] Disable Conceal passwords setting
- [ ] Unlock with TouchId
- [ ] Unlock with Apple Watch

### Things
- [ ] Enable Things Cloud

### Google Chrome
- [ ] Set downloads to `~/Dropbox/Devices/Downloads`
- [ ] Sign in to Google account and setup syncing

### Firefox
- [ ] Set downloads to `~/Dropbox/Devices/Downloads`
- [ ] Sign in to Firefox account and setup syncing

### Raycast
- [ ] Configure Extensions or handled my Mackup?

## Alfred
- [ ] Configure Extensions or handled my Mackup?

### Drafts
- [ ] Install Extensions
  (Synced with iCloud)
    - Append to Obsidian, etc.

### Banktivity
- [ ] Setup sync to `Local` folder

### OBS
- [ ] Setup OBS profile

### Bunch
- [ ] Make sure bunches are working correctly

### WriteRoom
- [ ] Install themes
    - [ ] [Download from](https://blog.hogbaysoftware.com/tagged/writeroomtheme)
    - [ ] [Copy to](/Users/evan/Library/Containers/com.hogbaysoftware.WriteRoom.mac/Data/Library/Application Support/WriteRoom/Themes)
    - [ ] Set default theme as SolarizedDarkWriteRoomTheme

### Bunch
- [ ] Make sure bunches are working correctly

### Yoink
- [ ] Configure extensions, services, behavior, etc.

## Fonts
- [ ] Change iTerm and VS Code Terminal to Powerline Font
    - [ ] Powerline font is installed by setupMac.sh and Mackup restores iTerm and VS Code settings

## Set Default "open with" for file types.
(If duti tool in configureMacSettings.sh didn't work, use SwiftDefaultApps Mac Preference Pane app to fill in the gaps. If neither the duti tool or the SwiftDefaultApps app works, then fall back on the manual/normal method of going to that file type's Get Info panel in Finder and changing it with Open with: > Change All....)
- [ ] VS Code: py, js, ts, go, java, etc. any serious programming.
- [ ] VS Code Insiders:
    - [ ] shell and git editor
- [ ] Nova: general text or no extension, config files, git, bash scripting, sh, dotfiles, etc.
    - [ ] txt
    - [ ] pem
    - [ ] pub
    - [ ] ini
    - [ ] xml
    - [ ] yaml
    - [ ] json
    - [ ] diff
    - [ ] conf
    - [ ] old
    - [ ] plist
    - [ ] log
    - [ ] csv
    - [ ] bunch
- [ ] Typora: md
- [ ] Transmit: ftp
- [ ] Mail: email
- [ ] VLC: Multimedia (mov, mp4, aac, mkv, etc.)

## Configure Custom Hotkeys
- [ ] Use CustomShortcuts app when you can
- [ ] Set hotkeys from [Custom Apple Hotkeys](obsidian://open?vault=Memex&file=Tech%2FPlatforms%2FCustom%20Apple%20Hotkeys)

## Install and Configure Browser Extensions
(Safari, Firefox, Chrome, et al)
- [ ] 1Password
- [ ] LastPass
- [ ] SuperAgent
- [ ] DarkReader
- [ ] StopTheMadness
- [ ] Hush
- [ ] Choosy
- [ ] IINA
- [ ] Downie
- [ ] Vinegar
- [ ] Diigo?
- [ ] Jetbrains?
- [ ] AdBlock (non-Safari)?
- [ ] React Developer Tools?

## Open at Login
- [ ] Bartender
- [ ] Batteries
- [ ] BeFocused
- [ ] Duplicati?
- [ ] Fantastical?
- [ ] FastScripts?
- [ ] Launchbar?
- [ ] Mission Control Plus
- [ ] Mobile Mouse Server
- [ ] Music
- [ ] Noizio
- [ ] Workspaces?
- [ ] Bunch
- [ ] 1Password
- [ ] Amphetamine
- [ ] Backtrack
- [ ] BetterTouchTool
- [ ] Cardhop
- [ ] Copyem
- [ ] Dropbox
- [ ] Google Voice
- [ ] Mail
- [ ] Messages
- [ ] Raycast
- [ ] Slack
- [ ] TextExpander
- [ ] Things
- [ ] Forklift
- [ ] OBS
- [ ] TaskPaper
- [ ] Obsidian
- [ ] Session
- [ ] Yoink

## Menubar

## Put secrets like ssh, certs, vpn, etc. in environment
### ssh keys
#### Generate ssh keys with passphrase in `~/.ssh` folder
(ed25519 is newer and better, but might not be supported by default, e.g., Ubuntu)
- [ ] `ssh-keygen -t ed25519 -C "id_personal"`
- [ ] `ssh-keygen -t rsa -b 4096 -C "id_personal_rsa"`
- [ ] `ssh-keygen -t ed25519 -C "id_<work_name>"`
- [ ] `ssh-keygen -t rsa -b 4096 -C "id_<work_name>_rsa"`
- [ ] Save in 1Password

#### Add ssh Keys to Apple Keychain to Avoid re-entering Passphrase
- [ ] `ssh-add --apple-use-keychain .ssh/id_personal`
- [ ] `ssh-add --apple-use-keychain .ssh/id_personal_rsa`
- [ ] `ssh-add --apple-use-keychain .ssh/id_<work_name>`
- [ ] `ssh-add --apple-use-keychain .ssh/id_<work_name>_rsa`

#### Add any hosts to `~/.ssh/config` file
E.g.:
  ```
  **# GitHub.com - Personal**
  Host github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_personal
  ```

### Environment Secrets
- [ ] Add to machine's `~/.dotfiles/.env` (which should be excluded from Mackup, etc.)

### VPN
vpn - make a .vpn folder?

### Certificates

## Backup
- [ ] Backblaze/Duplicati
- [ ] Dropbox backup feature
- [ ] Time Machine
- [ ] Super Duper
- [ ] Carbon Copy Cloner

## Todo
- wifi calling
