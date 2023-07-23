#!/bin/sh -x

#==============================================================================
#                       Update Python
#==============================================================================
# Script to update Python.

echo -e "\033[1;32m  ......Starting updatePython.sh......  \033[0m"

python3 -m pip install --upgrade pip
pip3 install --upgrade -r ../languages/python/requirements.txt

echo -e "\033[0;31m  ======Finished updatePython.sh======  \033[0m"
