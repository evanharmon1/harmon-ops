#!/bin/sh -x

echo -e "\033[1;32m  ......Starting setupPython.sh......  \033[0m"
# Based on whatever the version homebrew installs
ln -s -f /opt/homebrew/bin/python3 /usr/local/bin/python3
ln -s -f /opt/homebrew/bin/pip3 /usr/local/bin/pip3

pip3 install -r requirements.txt

echo -e "\033[0;31m  ======Finished setupPython.sh======  \033[0m"
