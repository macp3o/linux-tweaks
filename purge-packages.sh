#! /bin/bash
#
# Remove unnecessary packages and fonts
#
# MUST BE RUN AS ROOT
#

if [ `id -u` -ne 0 ]; then
	echo "Must be run as root"
	exit 1
fi


# 1- Mono for security
# 2- Banshee depends on mono -- vlc is good
# 2- Thunderbird (desktop email)
# 4- Unnecessary fonts

apt-get purge -y \
	mono-runtime-common cli-common \
	banshee \
	command-not-found command-not-found-data \
	thunderbird \
	fonts-sil-abyssinica fonts-kacst fonts-kacst-one fonts-khmeros-core \
	fonts-lklug-sinhala fonts-nanum fonts-sil-padauk \
	fonts-lao fonts-tibetan-machine fonts-thai-tlwg \
	fonts-tlwg-garuda fonts-tlwg-kinnari fonts-tlwg-loma fonts-tlwg-mono \
	fonts-tlwg-norasi fonts-tlwg-purisa fonts-tlwg-sawasdee \
	fonts-tlwg-typewriter fonts-tlwg-typist fonts-tlwg-typo \
	fonts-tlwg-umpush fonts-tlwg-waree \
	fonts-takao-pgothic fonts-wqy-microhei \
	fonts-liberation \
	ttf-indic-fonts-core ttf-punjabi-fonts ttf-wqy-microhei


# Mint-specific removals

grep -qs LinuxMint /etc/lsb-release && apt-get purge -y \
	mintwelcome mintnanny mint-search-addon firefox-locale-en



