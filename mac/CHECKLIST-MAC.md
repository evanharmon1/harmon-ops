# CHECKLIST-MAC.md
Checklist for setting up a new Mac from scratch.

## 1. **Install macOS** from scratch
- [x] Full Name: Evan Harmon
- [x] Account Name: evan
	- [x] Recover password from iCloud option: no
- [x] FindMy: yes
- [x] Location Services: yes
- [x] Analytics: no
- [x] Screentime: yes
- [x] Siri: yes
- [x] Improve Siri: no
- [x] FileVault encryption: yes
	- [x] Recover passwoed from iCloud option: no
- [x] Apple Pay: setup
- [x] Appearance: Auto

## 2. Sign into **iCloud** and enable everything to start syncing
- [x] All on, including keychain
- [x] Turn on sync desktop and documents
- [x] Choose profile pic
- [ ] Optimize Mac Storage - yes for laptop? No for server.
- [ ] private relay - yes, when out of beta

## 3. Authenticate Mac App Store & setup xCode
- [x] Install xCode via Mac App Store
- [x] Open xCode
	- [x] It will ask to install Rosetta - yes
	- [x] Install git command line tools.

## 4. Download **Dropbox** and start syncing so I can get my Dropbox dev folder with **dev-env** repo and setupMac.sh
- [x] Turn on accessbility: yes?
- [x] Verify when deleting off of Dropbox: No
- [x] Share screenshots and recordings using Dropbox: Yes
- [x] Choose Folders to sync:
	- [x] Everything
- [x] Files stored with: Local (not online-only)
- [x] Smart sync: No
- [x] Store in default location - Users/evan/Dropbox

## 5. Run **setupMac.sh** from its directory at ~/Dropbox/dev/DevEnv/dev-env/mac
- [x] Double check setupMac.sh
	- [x] Verify Brewfile packages are what you want
	- [x] Check what dotfiles from Mackup in iCloud will be linked over to the local machine and delete any from iCloud that are not wanted.
- [x] Clean reboot
- [x] `caffeinate -disu ./setupMac.sh`

## 5. Connect Peripherals
- [x] Keyboards
- [x] Mice
- [x] Printers
  - [x] Test print


## 6. Configure remaining Apple **Manual Settings** not set in `configureMacSettings.sh`
### Storage Management.app
- [x] Store in iCloud
	- [x] Desktop and Documents
	- [x] Photos
- [x] Empty Trash automatically

### Settings > General
- [x] Appearance - Auto
- [x] Accent Color - Multicolor
- [x] Scroll bars - automatic, and jump to position
- [x] Recent items - 50
- [x] close windows when quitting an app - no

### Settings > Desktop & Screensaver
- [x] Screensaver
	- [x] Start after 20 minutes
	
### Settings > Dock & Menu Bar
- [x] Double click window title bar to zoom
- [x] Battery - show percentage, in menubar and control center
- [x] Spotlight: Show in menubar - no
- [x] Siri: Show in menubar - no
- [ ] Time Machine: Show in menubar - yes, if doing Time Machine
- [x] Clock > Date: Show day of week, show date, show am/pm
- [x] Add Downloads folder to Dock
  - [x] Sort by: Date Added
  - [x] Display as: Folder
  - [x] View Content as: Grid


### Settings > Mission Control & Spaces
- [x] Auto rearrange spaces - no

### Settings > Notifications & Focus
- [x] Allow notifications
	- [x] When display is sleeping - no
	- [x] When display is locked - yes
	- [x] When mirroring or sharing display - no
	
### Settings > Internet Accounts
- [x] Google
	- [x] Google Mail only, not calendar, etc.
	
### Settings > Wallet & Apple Pay
- [x] Enable

### Settings > Users & Groups
- In general, it's easier to just have most people be admins. It's kind of annoying otherwise where they can't even restart the computer, etc.

- [x] Enable guest account if visitors might want to use it.

### Settings > Accessibility
- [x] Zoom - Use scroll gesture with modifier keys to zoom - ctrl
- [x] Pointer Control - Mouse & Trackpad - Spring loaded delay - second shortest
- Hot Corners?

### Settings > Extensions

- [x] Enable pretty much everything

- [x] Create Open in... extensions with Automator

  - [Open anything in VS Code using a MacOS quick action](https://www.jimbobbennett.io/open-anything-in-vs-code-using-a-macos-quick-action/)

  - [x] Open in VS Code

    - Workflow receives current files or folders in any application
  
  - Run Shell Script
    - Pass input as arguments

    - `open -n -b "com.microsoft.VSCode" --args "$*" `
- [x] Open in VS Codium
  
  - Workflow receives current files or folders in any application
    - Run Shell Script
    - Pass input as arguments
  - `open -n -b "com.visualstudio.code.oss" --args "$*" `

- [x] Install Brett Terpstra's Markdown Service Tools
  - [Markdown Service Tools - BrettTerpstra.com](https://brettterpstra.com/projects/markdown-service-tools/)


### Settings > Security & Privacy
- [x] Require password 5 seconds after sleep or screen saver
- [x] Use Apple Watch to unlock Mac
- [x] Filevault on

### Settings > Software Update
- [x] Turn off "Keep Mac up to date" and don't check for updates. Let my updateMac.sh service do it.

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

### Settings > Date & Time
- [ ] Set date and time auto
- [ ] Set timezone automatically
- [ ] Show day of week and date in menu bar

### Settings > Sharing
- [ ] In general keep everything off unless you need to have it on. E.g. if you setup Screens or need to share files temporarily. But then should probably turn it off.
- [ ] AirPlay Receiver - yes
- [ ] Content caching - on for servers, no for laptops

### Finder (todo)
// Todo 
- [ ] Add ~/Dropbox/Devices/Downloads to Finder sidebar and remove system Downloads folder

### Safari (todo)
- [ ] Set downloads to `~/Dropbox/Devices/Downloads`
### Notification Center/Sidebar Thing
- [ ] Tomorrow
- [ ] Weather - Current, Hill City
- [ ] Batteries (fadel.io)
- [ ] Deliveries

### Messages
- [ ] iMessages in iCloud: enable in iMessages app
- [ ] Enable photo and sharing thing? 
	
## 7. Download Remaining 3rd Party Apps that Aren't Available in Homebrew Repos
- [x] [Markdown Service Tools - BrettTerpstra.com](https://brettterpstra.com/projects/markdown-service-tools/)
- [x] [Aeon Timeline](https://timeline.app/download/)
- [x] [Textsniper](https://textsniper.app/api/downloads/mac-latest)
- [x] [Squash](https://www.realmacsoftware.com/download/squash/)
- [x] [Textsoap](https://textsoap.com/mac/)
- [x] [Amphetamine Enhancer](https://github.com/x74353/Amphetamine-Enhancer/raw/master/Releases/Current/Amphetamine%20Enhancer.dmg)
- [x] [Copy'em Helper](https://apprywhere.com/ce-helper.html)
- [x] [MailSuite](https://smallcubed.com/)

## 8. Configure Remaining 3rd Party App Settings (todo)
### Open all applications:

- register licenses, if necessary

- login/setup sync, if necessary
- accept/deny notifiactions
- start at login, if necessary
- Install browser extensions, if necessary

### Make webapps local with Fluid.app or Unite.app
- [x] Google Voice and add to Dock after Slack
- [x] Google Meet and add to dock after Google Voice
- [x] Confluence?

### iTerm
- [x] iTerm: import iterm/EvansDefault.json to iterm profiles and set as default
- [x] Hotkey - open iTerm - Double tap ctrl

### VS Code
- [x] Install command line tools

### VS Codium

- [x] Install command line tools

### TextMate

- [x] Install command line tools

### Nova
- [x] Install command line tools

### BBedit
- [x] Install command line tools

### 1Password
  - [x] Safari Extension
  - [x] FireFox Extension
  - [x] Google Chrome Extension
  - [x] Menubar App
  - [x] Disable Conceal passwords setting
  - [x] Unlock with TouchId
  - [x] Unlock with Apple Watch

### Things
  - [x] Enable Things Cloud

### Google Chrome

- [x] Set downloads to `~/Dropbox/Devices/Downloads`
- [x] Sign in to Google account and setup syncing

### Firefox

- [x] Set downloads to `~/Dropbox/Devices/Downloads`
- [x] Sign in to Firefox account and setup syncing

### Raycast

- [ ] Configure Extensions

### Drafts

- [ ] Install Extensions
  - (Synced with iCloud)
  - Append to Obsidian, etc.


### Banktivity

  - [ ] Setup sync to `Local` folder

### OBS

- [x] Setup OBS profile

### Workspaces (todo)

### Bunch

- [x] Make sure bunches are working correctly

### WriteRoom

- [x] Install themes
  - [x] [Download from](https://blog.hogbaysoftware.com/tagged/writeroomtheme)
  - [x] [Copy to](/Users/evan/Library/Containers/com.hogbaysoftware.WriteRoom.mac/Data/Library/Application Support/WriteRoom/Themes)
  - [x] Set default theme as SolarizedDarkWriteRoomTheme

### Yoink

- [ ] Configure extensions, services, behavior, etc.

## Fonts

- [x] Change iTerm and VS Code Terminal to Powerline Font
  - [x] ITerm2 > Preferences > Profiles > Text > Change Font
    - [x] Meslo LG DZ for Powerline
  - [x] Open Settings
    - [x] Terminal Integrated font family: Meslo LG L DZ for Powerline

## 9. Set Default "open with" for file types.

- If duti tool in configureMacSettings.sh didn't work, use SwiftDefaultApps Mac Preference Pane app to fill in the gaps. If neither the duti tool or the SwiftDefaultApps app works, then fall back on the manual/normal method of going to that file type's Get Info panel in Finder and changing it with Open with: > Change All....

- [x] Nova: general text or no extension, config files, git, bash scripting, sh, dotfiles, etc.
  - [x] txt
  - [x] pem
  - [x] pub
  - [x] ini
  - [x] xml
  - [x] yaml
  - [x] json
  - [x] diff
  - [x] conf
  - [x] old
  - [x] plist
  - [x] log
  - [x] csv
  - [x] bunch
  
- [x] VS Code: py, js, ts, go, java, etc. any serious programming.

- [x] Typora: md

- [x] Transmit: ftp

- [x] Mail: email

- [x] IINA: Multimedia (mov, mp4, aac, mkv, etc.)

## 10. Configure Custom Hotkeys

- Use CustomShortcuts app when you can

Set hotkeys from [Custom Apple Hotkeys](obsidian://open?vault=Memex&file=Tech%2FPlatforms%2FCustom Apple Hotkeys)

## Install and Configure Browser Extensions

- Safari, Firefox, Chrome
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

## 12. Open at Login
- [x] Bartender
- [ ] Batteries
- [ ] BeFocused
- [ ] Duplicati?
- [ ] Fantastical?
- [ ] FastScripts?
- [ ] Launchbar?
- [ ] Mission Control Plus
- [ ] Mobile Mouse Server
- [x] Music
- [x] Noizio
- [ ] Workspaces?
- [x] Bunch
- [x] 1Password
- [x] Amphetamine
- [x] Backtrack
- [x] BetterTouchTool
- [x] Cardhop
- [x] Copyem
- [x] Dropbox
- [x] Google Voice
- [x] Mail
- [x] Messages
- [x] Raycast
- [x] Slack
- [x] TextExpander
- [x] Things
- [x] Forklift
- [x] OBS
- [x] TaskPaper
- [x] Obsidian
- [ ] Session
- [x] Yoink

## 13. Menubar

## 14. Put secrets like ssh, certs, vpn, etc. in environment
### ssh Keys

#### Generate ssh Keys with Passphrase in `~/.ssh` Folder

- ed25519 is newer and better, but might not be supported by default, e.g., Ubuntu
- [x] `ssh-keygen -t ed25519 -C "id_personal"`
- [ ] `ssh-keygen -t rsa -b 4096 -C "id_personal_rsa"`
- [x] `ssh-keygen -t ed25519 -C "id_<work_name>"`
- [x] `ssh-keygen -t rsa -b 4096 -C "id_<work_name>_rsa"`
- [x] Save in 1Password

#### Add ssh Keys to Apple Keychain to Avoid re-entering Passphrase
- [x] `ssh-add --apple-use-keychain .ssh/id_personal`
- [ ] `ssh-add --apple-use-keychain .ssh/id_personal_rsa`
- [ ] `ssh-add --apple-use-keychain .ssh/id_<work_name>`
- [ ] `ssh-add --apple-use-keychain .ssh/id_<work_name>_rsa`

#### Add any hosts to `~/.ssh/config` file

- E.g.:

  ```
  **# GitHub.com - Personal**
  Host github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_personal
  ```

### Environment Secrets

- [ ] Add to `~/.dotfiles/.env`

### VPN

vpn - make a .vpn folder?

### Certificates

## 15. Backup
- [ ] Backblaze/Duplicati and/or Dropbox
- [ ] Time Machine
- [ ] Super Duper


## Todo
- wifi calling
