#!/bin/sh -x

#==============================================================================
#                       Setup Python
#==============================================================================
# Script to setup Python on a new developer environment.

echo -e "\033[1;32m  ......Starting setupPython.sh......  \033[0m"

pip3 install -r ../languages/python/requirements.txt

echo -e "\033[0;31m  ======Finished setupPython.sh======  \033[0m"
