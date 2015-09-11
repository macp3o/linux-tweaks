#! /bin/bash
#
# Add useful packages not installed by default
#
# MUST BE RUN AS ROOT
#

# 1- Firmware
# 2- Networking tools
# 3- Multimedia tools
# 4- Social networking (slack works with pidgin, but not empathy)
# 5- Font-manager and extra fonts: lato, ms fonts

apt-get install -y \
	linux-freeware-nonfree traceroute whois \
	k3b kino audacity gtk-recordmydesktop \
	skype pidgin pidgin-otr pidgin-plugin-pack \
	font-manager \
	fonts-lato ttf-mscorefonts-installer

# 6- Install merriweather font
GOOGLE_FONTS=https://raw.githubusercontent.com/google/fonts/master

FNT_DIR=/usr/share/fonts/truetype/merriweather
mkdir -p $FNT_DIR
for STYLE in Regular Italic  Light LightItalic Bold BoldItalic Black HeavyItalic; do
	curl -o "$FNT_DIR/Merriweather-$STYLE.ttf" \
		"$GOOGLE_FONTS/ofl/merriweather/Merriweather-$STYLE.ttf"
done

fc-cache -fv


