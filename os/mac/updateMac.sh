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

#             Environment
#------------------------------------------------------------------------------
# Source local secrets for pushover, etc.
source ~/.secret

#             Notify - Starting updateMac.sh
#------------------------------------------------------------------------------
script_start_time=$(date +%s)
echo -e "\033[0;35m  ++++++Starting updateMac.sh - $(date +%FT%T)++++++  \033[0m"
echo "Path var = $PATH"

terminal-notifier -title "Starting updateMac.sh Script" \
-message "A script that updates this Mac's Homebrew, Mackup dotfiles, etc. " \
-contentImage mac-icon.png \
-sound Blow

# Pushover
curl -s \
  --form-string "token=$PUSHOVER_TOKEN" \
  --form-string "user=$PUSHOVER_USER" \
  --form-string "priority=0" \
  --form-string "message=Starting updateMac.sh at $script_start_time" \
  https://api.pushover.net/1/messages.json


#==============================================================================
#                       Mac App Store (mas)
#==============================================================================
#             Notify starting Mac App Store update
#------------------------------------------------------------------------------
echo -e "\033[0;35m  ......Starting mas update - Checking for and updating any Mac App Store updates......  \033[0m"
start_time=$(date +%s)

mas_outdated_apps_count=$(mas outdated | wc -l)
printf "Number of outdated Mac App Store apps BEFORE script: $mas_outdated_apps_count"

terminal-notifier -title "Starting mas update - Checking for and updating any Mac App Store updates" \
-message "$mas_outdated_apps_count apps are outdated. Attempting to update..." \
-contentImage mac-icon.png \
-sound Blow

#             Install updates in the Mac App Store
#------------------------------------------------------------------------------
mas upgrade

#             Notify finished Mac App Store update
#------------------------------------------------------------------------------
mas_outdated_apps_count=$(mas outdated | wc -l)
printf "# of outdated Mac App Store apps AFTER script: $mas_outdated_apps_count"

end_time=$(date +%s)
printf "Finished Mac App Store updates in $(($end_time - $start_time)) seconds."

terminal-notifier -title "Finished running mas to upgrade Mac App Store Software" \
-message "Time elapsed: $(($end_time - $start_time)) seconds - $(date +%FT%T). $mas_outdated_apps_count apps are still outdated after running mas upgrade..." \
-contentImage monitor-icon.icns \
-sound Glass

# Pushover
curl -s \
  --form-string "token=$PUSHOVER_TOKEN" \
  --form-string "user=$PUSHOVER_USER" \
  --form-string "priority=-2" \
  --form-string "message=Finished Mac App Store (mas) updates \
  Time elapsed: $(($end_time - $start_time)) seconds." \
  https://api.pushover.net/1/messages.json


#==============================================================================
#                       Homebrew
#==============================================================================
# Updates Homebrew and then upgrades all software that was installed with Homebrew
#             Notify starting Homebrew update
#------------------------------------------------------------------------------
echo -e "\033[0;35m  ......Starting Homebrew updates......  \033[0m"
start_time=$(date +%s)

terminal-notifier -title "Starting Homebrew updates" \
-message "brew update, brew upgrade, brew cleanup, brew bundle dump, and add new packages to BrewfileSuperset" \
-contentImage mac-icon.png \
-sound Blow

#             Update Homebrew
#------------------------------------------------------------------------------
brew update -v
brew upgrade -v
brew cleanup -v
brew bundle dump -v --describe --force --file=~/Brewfile

# Copy this machine's Brewfile to this machine's repo folder.
THIS_HOST=$(HOSTNAME)
mkdir "../../infra/${THIS_HOST}/"
\cp -fR ~/Brewfile "../../infra/${THIS_HOST}/"

# Add any newly installed Homebrew packages from this machine to the BrewfileSuperset file.
NEW_BREW_PACKAGES_COUNT=$(bash -c "comm -23 <(sort ~/Brewfile | grep -v '^#' | sed 's/, link: false\$//') <(sort ../brew/BrewfileSuperset | grep -v '^#'| sed 's/, link: false\$//') | wc -l")
echo "New Homebrew packages: $NEW_BREW_PACKAGES_COUNT"

if [ "$NEW_BREW_PACKAGES_COUNT" -gt 0 ]; then
    NEW_BREW_PACKAGES=$(bash -c "comm -23 <(sort ~/Brewfile | grep -v '^#' | sed 's/, link: false\$//') <(sort ../brew/BrewfileSuperset | grep -v '^#'| sed 's/, link: false\$//')")
    echo "$NEW_BREW_PACKAGES"

    # Add new packages to BrewfileSuperset
    echo "\n\n#                New Packages from $(hostname) $(date +%F)\n#-------------------------------------------------------------------------------" >> ../brew/BrewfileSuperset
    bash -c "comm -23 <(sort ~/Brewfile | grep -v '^#' | sed 's/, link: false\$//') <(sort ../brew/BrewfileSuperset | grep -v '^#'| sed 's/, link: false\$//') >> ../brew/BrewfileSuperset && echo ""$NEW_BREW_PACKAGES_COUNT" Homebrew packages were added to the BrewfileSuperset file.""
else
    echo "No new Homebrew packages to add to BrewfileSuperset."
fi

#             Notify finished Homebrew update
#------------------------------------------------------------------------------
end_time=$(date +%s)
printf "Finished Homebrew updates in $(($end_time - $start_time)) seconds."

terminal-notifier -title "Finished Homebrew updates" \
-message "Time elapsed: $(($end_time - $start_time)) seconds - $(date +%FT%T). $NEW_BREW_PACKAGES_COUNT Homebrew packages were added to the BrewfileSuperset file." \
-contentImage monitor-icon.icns \
-sound Glass

# Pushover
curl -s \
  --form-string "token=$PUSHOVER_TOKEN" \
  --form-string "user=$PUSHOVER_USER" \
  --form-string "priority=-2" \
  --form-string "message=Finished Homebrew updates \
  Time elapsed: $(($end_time - $start_time)) seconds." \
  https://api.pushover.net/1/messages.json


#============================================================================
#                       Dotfiles & Mackup
#============================================================================
# Mackup backs up supported app configs, settings, and dotfiles like .bash_profile to iCloud and then symlinks them back to original location
# The only reason I think I need to keep running mackup backup is to catch new files that aren't symlinked to iCloud.
#             Notify starting Mackup backup
#------------------------------------------------------------------------------
echo -e "\033[0;35m  ......Starting Mackup backup to symlink any new dotfiles, config files, etc. to iCloud......  \033[0m"
start_time=$(date +%s)

terminal-notifier -title "Starting Mackup backup" \
-message "mackup backup --force, mackup uninstall --force" \
-contentImage mac-icon.png \
-sound Blow

#             Run Mackup backup and copy new dotfiles to repo
#------------------------------------------------------------------------------
# -force argument avoids confirmation dialogs to allow automation.
# Due to macOS Sonoma security issue surrounding symlinks, the normal way Mackup works with symlinks is not reliable.
mackup backup --force

# Keep any modified dotfiles on machine in sync with dotfiles in this repo
rsync -ah --copy-links ~/.bashrc ../shell/bash/
rsync -ah --copy-links ~/.zshrc ../shell/zsh/

rsync -ah --copy-links ~/dotfiles/ ../shell/dotfiles/

rsync -ah --copy-links ~/.gitconfig ../git/
rsync -ah --copy-links ~/.gitignore_global ../git/

rsync -ah --copy-links ~/.mackup/myDotFiles.cfg mackup/
rsync -ah --copy-links ~/.mackup.cfg mackup/

#             Notify finished Mackup backup
#------------------------------------------------------------------------------
end_time=$(date +%s)
printf "Finished Mackup backup & dotfiles sync in $(($end_time - $start_time)) seconds."

terminal-notifier -title "Finished Mackup backup & dotfiles sync" \
-message "Time elapsed: $(($end_time - $start_time)) seconds - $(date +%FT%T)." \
-contentImage monitor-icon.icns \
-sound Glass

# Pushover
curl -s \
  --form-string "token=$PUSHOVER_TOKEN" \
  --form-string "user=$PUSHOVER_USER" \
  --form-string "priority=-2" \
  --form-string "message=Finished mackup backup & dotfiles sync \
  Time elapsed: $(($end_time - $start_time)) seconds." \
  https://api.pushover.net/1/messages.json


#==============================================================================
#                       JavaScript
#==============================================================================
../languages/javaScript/updateJavaScript.sh


#==============================================================================
#                       JavaScript
#==============================================================================
../languages/python/updatePython.sh


#==============================================================================
#                       Notify - Finished updateMac.sh
#==============================================================================
script_end_time=$(date +%s)
echo -e "\033[1;32m  ======Finished updateMac.sh in $(($script_end_time - $script_start_time)) seconds - $(date +%FT%T)======  \033[0m"

terminal-notifier -title "Finished updateMac.sh Script" \
-message "Finished updateMac.sh Script. Time elapsed: $script_end_time seconds - $(date +%FT%T)." \
-contentImage monitor-icon.icns \
-sound Glass

# Pushover
curl -s \
  --form-string "token=$PUSHOVER_TOKEN" \
  --form-string "user=$PUSHOVER_USER" \
  --form-string "priority=0" \
  --form-string "message=Finished updateMac.sh Time \
  elapsed: $(($script_end_time - $script_start_time)) seconds." \
  https://api.pushover.net/1/messages.json
