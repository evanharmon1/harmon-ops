#!/bin/zsh
sysctl kern.version
sysctl kern.ostype
sysctl kern.osrelease
sysctl kern.osrevision
uname -a
system_profiler SPSoftwareDataType SPHardwareDataType
sw_vers
neofetch
