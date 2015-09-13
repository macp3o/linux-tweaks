#! /bin/bash
#
# Install system tweaks
#


## -- UTILITIES --

BASEDIR=`dirname "$0"`

# sudocopy SOURCE_FILE DEST_DIR
# Copies a file from this script directory to a system directory
# The copied file is owned by root
# SOURCE_FILE must not not specify a path or contain spaces or special characters
function sudocopy {
	sudo sed -ne "w $2/$1" < "$BASEDIR/$1"
}

# run SCRIPT_NAME
# Executes a script as root from this script directory
function sudorun {
	chmod u+x "$BASEDIR/$1" && sudo "$BASEDIR/$1"
}


## -- GLOBAL SETTINGS -- --------------------------------------------------

# Sudo w/out password
sudocopy nopasswd-sudo /etc/sudoers.d

# Enable the firewall
sudo ufw enable

# Eliminate excessive swapping
sudocopy 80-minswap-sysctl.conf /etc/sysctl.d
sudo sysctl --system > /dev/null

# Accelerate ext3 and ext4 disk access -- discards access time
sudorun speed-disk.sh

# Accelerate the network: no ipv6 and improved caching dns
sudorun no-ipv6.sh
sudorun speed-net.sh

# Remove unnecessary services and packages
sudorun purge-services.sh
sudorun purge-packages.sh

# Add useful packages missing from the default installation
sudorun add-extra-packages.sh

# Configure nano: mouse, smooth scroll, line number, no help, no syntax highlight
sudocopy nanorc /etc

# Configure bash for all users
sudocopy custom-profile.sh /etc/profile.d



