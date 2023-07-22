#!/bin/sh -x

#==============================================================================
#                       Update JavaScript
#==============================================================================
# Script to update JavaScript

echo -e "\033[1;32m  ......Starting updateJavaScript.sh......  \033[0m"

npm update --location=global npm
npm update --location=global
npm doctor

echo -e "\033[0;31m  ======Finished updateJavaScript.sh======  \033[0m"
