#! /bin/bash
#
# Install system tweaks
#

pushd `dirname "$0"`

## -- UTILITIES --

# run SCRIPT_NAME
# Executes a script as root from this script directory
function sudorun {
	chmod u+x "$1" && sudo "$1"
}


## -- GLOBAL SETTINGS -- --------------------------------------------------

# Sudo w/out password
sudo cp -fu nopasswd-sudo /etc/sudoers.d/

# Enable the firewall
sudo ufw enable

# Eliminate excessive swapping
sudo cp -fu 80-minswap-sysctl.conf /etc/sysctl.d/
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
sudo cp -fu nanorc /etc/

# Configure bash for the current user and root
cp -fu bashrc ~/.bashrc
sudo cp -fu bashrc /root/.bashrc


popd

