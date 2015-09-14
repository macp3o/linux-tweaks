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
# 3- Font-manager and ms core fonts

apt-get install -y \
	linux-freeware-nonfree traceroute whois \
	font-manager ttf-mscorefonts-installer



