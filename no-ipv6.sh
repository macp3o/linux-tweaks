#! /bin/bash
#
# Disable IPv6 support -- accelerates the net, unless IPv6 is available from the network
#
# MUST BE RUN AS ROOT
#

if [ `id -u` -ne 0 ]; then
	echo "Must be run as root"
	exit 1
fi


# Disable the IPv6 module
#
echo 'blacklist ipv6' > /etc/modprobe.d/no-ip6.conf

# Configure sysctl to disable IPv6
#
cat > /etc/sysctl.d/80-noipv6.conf <<- "END"

	net.ipv6.conf.all.disable_ipv6 = 1
	net.ipv6.conf.default.disable_ipv6 = 1
	net.ipv6.conf.lo.disable_ipv6 = 1
	net.ipv6.conf.all.accept_ra = 0
	END

sysctl --system > /dev/null

# Comment out IPv6 hosts in /etc/hosts
#
sed -ine '/::/s/^/# /' /etc/hosts

# Change grub to disable IPv6
#
if ! `grep -qs 'GRUB_CMDLINE_LINUX_DEFAULT.*ipv6'  /etc/default/grub`; then
	sed -ine \
		'/GRUB_CMDLINE_LINUX_DEFAULT/s/$/ ipv6.disable=1/ ' \
		/etc/default/grub
	update-grub
fi




