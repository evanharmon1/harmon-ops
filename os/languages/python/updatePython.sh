#!/bin/sh -x

#==============================================================================
#                       Update Python
#==============================================================================
# Script to update Python.

# Source local secrets for pushover, etc.
source ~/.secret

start_time=$(date +%s)

echo -e "\033[1;32m  ++++++Starting updatePython.sh $(date +%FT%T)++++++  \033[0m"

terminal-notifier -title "Starting updatePython.sh Script" \
-message "A script that updates Python and packages." \
-contentImage mac-icon.png \
-sound Blow

python3 -m pip install --upgrade pip
brew install pipx
pipx ensurepath
pipx upgrade-all

end_time=$(date +%s)
echo -e "\033[0;31m  ======Finished updatePython.sh in $(($end_time - $start_time)) seconds $(date +%FT%T)======  \033[0m"

# Pushover
curl -s \
  --form-string "token=$PUSHOVER_TOKEN" \
  --form-string "user=$PUSHOVER_USER" \
  --form-string "priority=-2" \
  --form-string "message=Finished Python updates
Time elapsed: $(($end_time - $start_time)) seconds." \
  https://api.pushover.net/1/messages.json

terminal-notifier -title "Finished updatePython.sh Script" \
-message "Finished updatePython.sh Script. Time elapsed: $(($end_time - $start_time)) seconds - $(date +%FT%T)." \
-contentImage monitor-icon.icns \
-sound Glass
