#!/bin/sh -x

#==============================================================================
#                       Setup Python
#==============================================================================
# Script to setup Python on a new developer environment.

echo -e "\033[1;32m  ++++++Starting setupPython.sh++++++  \033[0m"

# Development Python packages to be installed globally

pipx install cookiecutter
pipx install whispers

#             Optional Global Packages
#------------------------------------------------------------------------------
# pipx install click
# pipx install numpy
# pipx install bcrypt
# pipx install pandoc
# pipx install pandas
# pipx install beautifulsoup4
# pipx install requests
# docker-compose
# PyYAML

echo -e "\033[0;31m  ======Finished setupPython.sh======  \033[0m"
