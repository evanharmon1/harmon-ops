#!/bin/sh -x

# Script to setup nodejs on a new developer environment.
# Installing npm packages globally with a package.json file is not supported.

echo -e "\033[1;32m  ......Starting setupNode.sh......  \033[0m"

# Base packages
npm install grunt --location=global #https://github.com/tldr-pages/tldr
npm install gulp --location=global
npm install pm2 --location=global
npm install moment --location=global
npm install babel-cli --location=global
npm install socketio --location=global
npm install dotenv --location=global
npm install puppeteer --location=global
npm install --location=global webpack
npm install --location=global jest
npm install --location=global mocha
npm install --location=global chai
npm install --location=global graphql


# Optional packages
#npm install -g gitlab-backup-util-harduino #https://www.npmjs.com/package/gitlab-backup-util-harduino

echo -e "\033[0;31m  ======Finished setupNode.sh======  \033[0m"
