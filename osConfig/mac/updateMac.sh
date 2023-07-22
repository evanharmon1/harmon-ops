#!/bin/sh -x

#==============================================================================
#                       Update Mac
#==============================================================================
# Author: Evan Harmon
# Shell script to run periodically and/or automatically to keep Mac up to date
# Run this script from the repo's osConfig/mac directory:
# `caffeinate -disu zsh -x ./updateMac.sh 2>&1 | tee -a ~/.log/updateMac.sh.log`
# Don't run as root or with sudo due to homebrew not wanting to run that way for security reasons.
# Can also run via Raycast
# Can setup as a cronjob with `updateMac.sh.cron`
# Can setup as a launchd service with com.evan.updateMac.plist but it was buggy
# last time so just use the cronjob and Raycast. And don't do it on system reboot.

#             Raycast
#------------------------------------------------------------------------------
# To run this script via Raycast
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title updateMac.sh
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 💻
# @raycast.needsConfirmation false

script_start_time=$(date +%s)
echo -e "\033[0;35m  ++++++Starting updateMac.sh - $(date +%FT%T)++++++  \033[0m"

terminal-notifier -title "Starting updateMac.sh Script" \
-message "A script that updates this Mac's Homebrew, Mackup dotfiles, etc. " \
-contentImage mac-icon.png \
-sound Blow


#============================================================================
#                       Homebrew
#============================================================================
# Updates Homebrew and then upgrades all software that was installed with Homebrew
echo -e "\033[0;35m  ......Running brew bundle to install and/or update packages in Brewfile......  \033[0m"
start_time=$(date +%s)

brew update -v
brew upgrade -v
brew cleanup -v
brew bundle dump -v --describe --force --file=~/Brewfile

# Copy this machine's Brewfile to this machine's repo folder.
THIS_HOST=$(HOSTNAME)
mkdir "../../infra/${THIS_HOST}/"
\cp -fR ~/Brewfile "../../infra/${THIS_HOST}/"

# Add any newly installed Homebrew packages from this machine to the BrewfileSuperset file.
NEW_BREW_PACKAGES_COUNT=$(bash -c "comm -23 <(sort ~/Brewfile | grep -v '^#' | sed 's/, link: false\$//') <(sort BrewfileSuperset | grep -v '^#'| sed 's/, link: false\$//') | wc -l")
echo "New Homebrew packages: $NEW_BREW_PACKAGES_COUNT"

if [ $NEW_BREW_PACKAGES_COUNT -gt 0 ]; then
    NEW_BREW_PACKAGES=$(bash -c "comm -23 <(sort ~/Brewfile | grep -v '^#' | sed 's/, link: false\$//') <(sort BrewfileSuperset | grep -v '^#'| sed 's/, link: false\$//')")
    echo $NEW_BREW_PACKAGES

    # Add new packages to BrewfileSuperset
    echo "\n\n#                New Packages from $(hostname) $(date +%F)\n#-------------------------------------------------------------------------------" >> BrewfileSuperset
    bash -c "comm -23 <(sort ~/Brewfile | grep -v '^#' | sed 's/, link: false\$//') <(sort BrewfileSuperset | grep -v '^#'| sed 's/, link: false\$//') >> BrewfileSuperset && echo "$NEW_BREW_PACKAGES_COUNT Homebrew packages were added to the BrewfileSuperset file.""
else
    echo "No new Homebrew packages to add to BrewfileSuperset.history"
fi

end_time=$(date +%s)
printf "Homebrew finished in $(($end_time - $start_time)) seconds."


#============================================================================
#                       Dotfiles & Mackup
#============================================================================
# mackup backs up supported app configs, settings, and dotfiles like .bash_profile to iCloud and then symlinks them back to original location
# The only reason I think I need to keep running mackup backup is to catch new files that aren't symlinked to iCloud.
echo -e "\033[0;35m  ......Running mackup backup to symlink any new dotfiles, config files, etc. to iCloud......  \033[0m"
start_time=$(date +%s)

# -force argument avoids confirmation dialogs
mackup backup --force

# If any other scripts or installations append anything to .zshrc, these commands move the fig lines to the bottom so they can still work.
move_line_to_bottom.sh '# Fig post block. Keep at the bottom of this file.' "/Users/evan/.zshrc"
move_line_to_bottom.sh '[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"' "/Users/evan/.zshrc"

# Keep any modified dotfiles on machine in sync with dotfiles in this repo
rsync -ah --copy-links ~/.bashrc ../shell/bash/
rsync -ah --copy-links ~/.zshrc ../shell/zsh/

rsync -ah --copy-links ~/.dotfiles/ ../shell/.dotfiles/

rsync -ah --copy-links ~/.gitconfig ../git/
rsync -ah --copy-links ~/.gitignore_global ../git/

rsync -ah --copy-links ~/.mackup/myDotFiles.cfg mackup/
rsync -ah --copy-links ~/.mackup.cfg mackup/

end_time=$(date +%s)
printf "Dotfiles & Mackup Updates finished in $(($end_time - $start_time)) seconds."


#==============================================================================
#                       Notify
#==============================================================================
script_end_time=$(date +%s)
echo "Time elapsed: $(($script_end_time - $script_start_time)) seconds"

# Pushover
source ~/Local/.secret
curl -s \
  --form-string "token=$PUSHOVER_TOKEN" \
  --form-string "user=$PUSHOVER_USER" \
  --form-string "message=Finished updateMac.sh

Time elapsed: $(($script_end_time - $script_start_time)) seconds." \
  https://api.pushover.net/1/messages.json

echo -e "\033[1;32m  ======Finished updateMac.sh in $(($script_end_time - $script_start_time)) seconds - $(date +%FT%T)======  \033[0m"

terminal-notifier -title "Finished updateMac.sh Script" \
-message "Finished updateMac.sh Script. Time elapsed: $(($script_end_time - $script_start_time)) seconds - $(date +%FT%T)." \
-contentImage monitor-icon.icns \
-sound Glass
