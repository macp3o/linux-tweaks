#! /bin/bash
#
# Configures ext3 and ext4 for faster disk access
#
# NOTICE: The system is assumed a clean install AND the default linux system in grub
# MUST BE RUN AS ROOT
#

if [ `id -u` -ne 0 ]; then
	echo "Must be run as root"
	exit 1
fi


# -- TUNE UP STRATEGIES --
#
# 1. Discard file and directory access time, since very few programs rely on this
#      If needed (e.g. for mutt), change noatime to reltime
# 2. Allow for potential mishandling of file write underway during a power failure
#     (the file being written may contain unitialized data)
# 3. Increase disk read-ahead buffer, change scheduler,
#      and eliminate disk contribution to random


# Save the original files, if not done yet
cp -np /etc/fstab /etc/fstab.original
cp -np /etc/default/grub /etc/default/grub.original
cp -np /etc/rc.local /etc/rc.local.original

# Patch ext4 options in /etc/fstab
sed -ine 's/\sext4\s\+\S\+/\text4\tdefaults,noatime,nodiratime,data=writeback,nobarrier,errors=remount-ro/' /etc/fstab

# Patch ext3
sed -ine 's/\sext3\s\+\S\+/\text3\tdefaults,noatime,nodiratime,errors=remount-ro/' /etc/fstab

# If data mode of root partition / was updated, update grub, if not done yet
if `grep -qs '\s/\s\+ext4\s' /etc/fstab` \
	-a ! `grep -qs 'GRUB_CMDLINE_LINUX_DEFAULT.*data'  /etc/default/grub`; then
	# Add rootflags=data=writeback to grub
	sed -ine \
		'/GRUB_CMDLINE_LINUX_DEFAULT/s/$/ rootflags=data=writeback/ ' \
		/etc/default/grub
	update-grub
fi

# Add udev rules
cp 99-speed-disk.rules /etc/dev/rules.d/
udevadm control --reload

# Change rc.local initialization
cp rc.local /etc/rc.local


