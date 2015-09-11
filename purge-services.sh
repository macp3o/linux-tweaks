#! /bin/bash
#
# Remove unnecessary services, including:
#   bluetooth, sane (scanner), cups (printer), avahi (some network services)
#
# MUST BE RUN AS ROOT
#

# Remove kerneloops -- it sends crash stats to kerneloops
service kerneloops stop
update-rc.d -f kerneloops remove

# Stop unnecessary services
for srv in saned bluetooth cups; do
	service $src stop
done
avahi-daemon --kill

# Purge the corresponding packages
apt-get purge -y \
	sane-utils \
	avahi-utils \
	cups cups-browsed \
	bluetooth bluez bluez-alsa bluez-cups bluez-gstreamer modem-manager


