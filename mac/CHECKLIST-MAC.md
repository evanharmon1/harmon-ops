# CHECKLIST-MAC.md
Checklist for manual steps to install a new Mac from scratch.

1. Install macOS from scratch
- [ ] FileVault encryption: enable
- [ ] Recover from iCloud option: disable
- [ ] FindMy: enable
- [ ] Location Services: enable
- [ ] Siri: enable
- [ ] Share audio: no

2. Sign into iCloud and enable everything to start syncing
- [ ] iMessages in iCloud: enable

3. Authenticate Mac App Store and install xCode

4. Download Dropbox and start syncing so I can get my Dropbox dev folder with dev-env repo and setupMac.sh

5. Run setupMac.sh from its directory at ~/Dropbox/dev/DevEnv/dev-env/mac
- [ ] caffeinate -disu ./setupMac.sh

6. Remaining Manual App Settings
- [ ] iTerm: import iterm/EvansDefault.json to iterm profiles and set as default
- [ ] Install command line tools for editors
    - VS Code
    - Nova
    - BBedit
- [ ] Set default open with app for file types
    - nova: general text or no extension
    - vscode: python, javascript, typescript
    - intellij: java

7. Put secrets like ssh, certs, etc. in environment
- [ ] ssh keys
- [ ] GitHub

8. Setup updateMac.sh to run periodically
