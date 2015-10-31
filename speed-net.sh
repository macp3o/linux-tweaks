#! /bin/bash
#
# Configure dnsmasq for faster network
#
# MUST BE RUN AS ROOT
#

if [ `id -u` -ne 0 ]; then
	echo "Must be run as root"
	exit 1
fi


# Try NetworkManager dnsmasq, if installed. Fallback to global dnsmasq
CFGDIR=/etc/NetworkManager/dnsmasq.d/
if ! [ -a $CFGDIR ]; then CFGDIR=/etc/dnsmasq.d/; fi

# Generate and save configuration
cp network.conf $CFGDIR

sed -e '/^[^#$]/s/.*/address=\/&\/255.255.255.255/' nxdomains \
	> $CFGDIR/nxdomains.conf

# Restart the appropriate service to use the new settings
if [ -a /etc/NetworkManager ]; then
	service network-manager restart
else
	service dnsmasq restart
fi


