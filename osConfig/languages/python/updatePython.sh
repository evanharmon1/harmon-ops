#!/bin/sh -x

#==============================================================================
#                       Update Python
#==============================================================================
# Script to update Python.

start_time=$(date +%s)

echo -e "\033[1;32m  ++++++Starting updatePython.sh $(date +%FT%T)++++++  \033[0m"

terminal-notifier -title "Starting updatePython.sh Script" \
-message "A script that updates Python and packages." \
-contentImage mac-icon.png \
-sound Blow

python3 -m pip install --upgrade pip
pip3 install --upgrade -r requirements.txt

end_time=$(date +%s)
echo -e "\033[0;31m  ======Finished updatePython.sh in $(($end_time - $start_time)) seconds $(date +%FT%T)======  \033[0m"

terminal-notifier -title "Finished updatePython.sh Script" \
-message "Finished updatePython.sh Script. Time elapsed: $(($end_time - $start_time)) seconds - $(date +%FT%T)." \
-contentImage monitor-icon.icns \
-sound Glass
