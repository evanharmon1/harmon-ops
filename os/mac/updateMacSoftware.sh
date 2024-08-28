#!/bin/sh -x

#==============================================================================
#                       Update Mac Software
#==============================================================================
# Author: Evan Harmon
# Shell script to run periodically and/or automatically to keep Mac App Store up to date via mas cli tool

script_start_time=$(date +%s)
echo -e "\033[0;35m  ++++++Starting updateMacSoftware.sh - $(date +%FT%T)++++++  \033[0m"
terminal-notifier -title "Starting updateMacAppStore.sh Script" \
-message "A script that updates Mac App Store with mas." \
-contentImage mac-icon.png \
-sound Blow

echo -e "\033[0;35m  ......Checking for and updating any Mac App Store updates with mas......  \033[0m"
start_time=$(date +%s)

# Install updates in the Mac App Store
timeout $((2 * 1)) mas upgrade

end_time=$(date +%s)
printf "Mac App Store updates finished in $(($end_time - $start_time)) seconds."

echo -e "\033[0;35m  ......Checking for and updating any Apple software updates with softwareupdate......  \033[0m"
start_time=$(date +%s)

# Mac system software updates and restart if needed
timeout $((2 * 1)) softwareupdate --install --all —verbose

end_time=$(date +%s)
printf "Apple Software Updates finished in $(($end_time - $start_time)) seconds."

script_end_time=$(date +%s)
echo -e "\033[1;32m  ======Finished updateMacSoftware.sh - $(date +%FT%T)======  \033[0m"

terminal-notifier -title "Finished updateMacAppStore.sh Script" \
-message "Finished updateMacAppStore.sh Script. Time elapsed: $(($script_end_time - $script_start_time)) seconds - $(date +%FT%T)." \
-contentImage monitor-icon.icns \
-sound Glass
