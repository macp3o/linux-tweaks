#! /bin/bash
#
# Add useful packages not installed by default
#
# MUST BE RUN AS ROOT
#

if [ `id -u` -ne 0 ]; then
	echo "Must be run as root"
	exit 1
fi

# 1- Firmware
# 2- Networking tools
# 3- System tools
# 4- Font-manager and korean and ms core fonts
apt-get install -y \
	linux-freeware-nonfree traceroute whois iotop \
	font-manager ttf-mscorefonts-installer fonts-unfonts-core

# Add cpu microcode patches
if [ `grep -q Intel /proc/cpuinfo` ]; then
	apt-get install -y iucode-tool intel-microcode
fi


