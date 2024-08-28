# CHECKLIST-MAC.md
Checklist for setting up a new Mac

## **Install macOS** from scratch
- [ ] Erase your Mac with Erase Assistant:
    - [ ] https://support.apple.com/guide/mac-help/erase-and-reinstall-macos-mh27903/mac
- [ ] If Intel Mac before T2 Security Chip:
    - If you need to create Bootable media for the macOS version you want to install:
        - https://support.apple.com/en-us/HT201372
- [ ] Full Name: Evan Harmon
- [ ] Account Name: evan
	- [ ] Recover password from iCloud option: no
- [ ] FindMy: yes
- [ ] Location Services: yes
- [ ] Analytics: no
- [ ] Screentime: yes
- [ ] Siri: yes
- [ ] Improve Siri: no
- [ ] FileVault encryption: yes
	- [ ] Recover password from iCloud option: no
	- [ ] Store FileVault Encryption recovery key in password manager
        - Store key locally until later steps install 1Password
- [ ] Apple Pay: yes
- [ ] Appearance: Auto (server: dark)

## Sign into **iCloud** and enable everything to start syncing
- [ ] All on, including keychain
- [ ] iCloud Drive: Sync desktop and documents: yes
- [ ] Optimize Mac Storage: yes, if OS drive is small, no if you want to replicate iCloud to the machine.
- [ ] Find My Mac: yes
- [ ] Private relay - yes
- [ ] Advanced Data Protection: yes
- [ ] Access iCloud Data on the Web: yes, but consider turning off in the future

## Authenticate **Mac App Store** & download Amphetamine & setup remote access
- [ ] Install Amphetamine via Mac App Store
- [ ] Turn on Amphetamine indefinitely to make sure it stays on and you can connect etc. until you get the machine mostly setup. (Although the `caffeinate` command should keep the Mac awake while that script is running.)
- [ ] Install Screens Connect and get remote access working so you can check in on progress of setup from anywhere.

## Download or Airdrop harmon-ops repo (this repo) to `~/git`
- [ ] [harmon-ops](https://github.com/evanharmon1/harmon-ops)]

## Run bootstrapMac.sh (sets hostnames, installs Homebrew, runs `softwareupdate`, copies `Brewfile` & `CHECKLIST.md`)
- [ ] Run `bootstrapMac.sh` from `os/mac`:
`cd ~/git/harmon-ops/os/mac && caffeinate -disu ./bootstrapMac.sh
- [ ] Script will ask you to set hostnames for this machine.
- [ ] Make sure to run the commands that Homebrew says in order to add `brew` to `$PATH` correctly:
    - [ ] `(echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/evan/.zprofile`
    - [ ] `eval "$(/usr/local/bin/brew shellenv)"`
- [ ] Homebrew should install git automatically, but if you need to manually install Xcode CLI tools and git: `xcode-select --install`.
- [ ] Restart, if needed by `softwareupdate`. Probably should restart regardless.

## `BrewfileSuperset` and `CHECKLIST-MAC.md`
- [ ] Use the newly copied `CHECKLIST-MAC.md` in `infra/<this-machine>` to keep track of progress of this machine's setup.
- [ ] Modify the newly copied `BrewfileSuperset` renamed at `~/Brewfile` based on the machine you're configuring (delete and add any apps/packages you want installed to this machine).
- [ ] Eventually, push and merge these changes to the repo, but merging is not required to move on to the following steps.

## Run `setupMac.sh`
- [ ] Double check that the `setupMac.sh` script is doing what you want for this machine.
- [ ] Run `setupMac.sh` from `os/mac`:
`cd ~/git/harmon-ops/os/mac && caffeinate -disu zsh -x ./setupMac.sh 2>&1 | tee -a ~/.log/setupMac.sh.log`
- The script usually needs a few Mac password prompts, so check it periodically.
- You need to type "exit" when oh-my-zsh is installed to exit that terminal and return to the rest of the setupMac.sh script

## Setup 1Password & Secrets
- [ ] Open 1Password and authenticate:
`open -a 1Password`
- [ ] Copy secret file to ~/.secret

## Run `updateMac.sh`
- [ ] Make sure there are no remaining Mac system software updates and restart if needed: `softwareupdate --install --all --restart`
- [ ] Double check that `updateMac.sh` is going to do what you want for this machine.
- [ ] Run `updateMac.sh` from `os/mac` and take note of any errors:
`cd ~/git/harmon-ops/os/mac && caffeinate -disu zsh -x ./updateMac.sh 2>&1 | tee -a ~/.log/updateMac.sh.log`
- [ ] If `updateMac.sh` runs correctly, then setup `updateMac.sh` to run automatically as a cronjob:
    - [ ] Copy and paste `os/mac/updateMac.sh.cron` text into crontab: `export VISUAL=vim && crontab -e` and set a daily schedule.
        - E.g., 10 19 * * * would be every day at 7:10 PM.
- [ ] Double check cronjob works automatically as scheduled. #TODO: add logs to log aggregator.
- [ ] Add `updateMac.sh` script to Raycast scripts for an easy way to manually run updateMac.sh when needed.








## Download **Dropbox** and start syncing
- [ ] https://www.dropbox.com/install
    - (Lets you skip account signin in the browser)
- [ ] Choose Folders to sync to this Mac (Selective Sync): only the dev/HarmonOps folder for now
- [ ] How should Dropbox sync to this Mac?: Local for now, then Online-only
    - (if you want to replicate to this Mac, then Local, which downloads everything locally all the time, regardless of use)
    - (Online-only setting only downloads to local computer when you open it. Then it might also stay local indefinitely?)
### Dropbox App Settings
- [ ] Make sure upgrade to newer Dropbox client is installed (the one that you upgrade in the app so it's compatible with newer Apple security).
- [ ] Backup: no (not sure if DropBox backup is end-to-end and at rest encrypted or if it's key is fully user-controlled - I don't think it is.)
- [ ] Verify when deleting off of Dropbox: No
- [ ] Share screenshots and recordings using Dropbox: No (Use CleanShot X)
- [ ] Upload Photos: No
- [ ] Ask to backup connected external drives: No
- [ ] Smart sync: No






## Connect **Peripherals**
- [ ] Keyboards
- [ ] Mice
- [ ] Printers
  - [ ] Test print






- [ ] Apple Software Update
    - [ ] Turn on auto update and install for everything - security, macOS, and App Store




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
- [ ] Keyboard Key Repeat and Delay Until Repeat to highest asd
- [ ] Text Expansion
	- [ ] Try to keep the main ones in sync with TextExpander
		- Like “zhome” etc.
		- I think it works ok for both to be active
		- The Apple ones will work in any application in iOS e.g.
- [ ] Enable Dictation
- [ ] Show input menu in menubar
- Karabiner (Should be handled by Mackup dotfiles)
    - Setup Karabiner to treat each external keyboard as the same system keyboard so I can use both at the same time. (Might be all in the config json.)
    - CapsLock > Esc
    - CapsLock (Held down) > Quasi-hyper key (Ctrl-Opt-Cmd)
    - Esc > CapsLock

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
