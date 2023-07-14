#!/bin/sh
ifconfig -a
sysctl kern.version
sysctl kern.ostype
sysctl kern.osrelease
sysctl kern.osrevision
uname -a
hostname -f
system_profiler SPSoftwareDataType SPHardwareDataType
sw_vers
neofetch
