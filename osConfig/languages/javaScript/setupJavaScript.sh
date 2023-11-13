#!/bin/sh -x

#==============================================================================
#                       Setup JavaScript
#==============================================================================
# Script to setup JavaScript, Node.js on a new developer environment.
# Installing npm packages globally with a package.json file is not supported.

echo -e "\033[1;32m  ++++++Starting setupJavaScript.sh++++++  \033[0m"

# Base packages
npm install grunt --location=global
npm install gulp --location=global
npm install pm2 --location=global
npm install socketio --location=global
npm install dotenv --location=global
npm install puppeteer --location=global
npm install eslint --location=global

#             Optional packages
#------------------------------------------------------------------------------
#
#npm install gitlab-backup-util-harduino --location=global #https://www.npmjs.com/package/gitlab-backup-util-harduino

echo -e "\033[0;31m  ======Finished setupJavaScript.sh======  \033[0m"
