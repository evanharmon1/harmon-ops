#!/bin/sh -x

#==============================================================================
#                       Update JavaScript
#==============================================================================
# Script to update JavaScript

start_time=$(date +%s)

echo -e "\033[1;32m  ++++++Starting updateJavaScript.sh $(date +%FT%T)++++++  \033[0m"

terminal-notifier -title "Starting updateJavaScript.sh Script" \
-message "A script that updates JavaScript and npm packages." \
-contentImage mac-icon.png \
-sound Blow

npm update --location=global npm 2>&1 | tee -a ~/.log/updateJavaScript.sh.log
npm update --location=global 2>&1 | tee -a ~/.log/updateJavaScript.sh.log
npm doctor 2>&1 | tee -a ~/.log/updateJavaScript.sh.log

end_time=$(date +%s)
echo -e "\033[0;31m  ======Finished updateJavaScript.sh in $(($end_time - $start_time)) seconds - $(date +%FT%T)======  \033[0m"

terminal-notifier -title "Finished updateJavaScript.sh Script" \
-message "Finished updateJavaScript.sh Script. Time elapsed: $(($end_time - $start_time)) seconds - $(date +%FT%T)." \
-contentImage monitor-icon.icns \
-sound Glass
