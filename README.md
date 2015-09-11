# Tux Tweaks

Tux-tweaks are tweaks I apply to Debian-based Linux systems after installation.

The tweaks come into two groups:
* Tweaks that can be applied automatically by script, and
* Tweaks that require manual intervention.

Both are described in this document.


## Installation

For the installation of **all** automated tweaks:
~~~
	$ chmod u+x INSTALL.sh
	$ ./INSTALL.sh
~~~
**WARNING**. `INSTALL.sh` removes several services and programs that were installed by the system.

Individual tweaks can be applied selectively by running the other included scripts or copying configuration files to the location indicated in the top of each file. All scripts, except for install.sh, must be run as root.  


## Features

### 1. Sudo without password
Prevents sudo from asking for passwords from users belonging to the `sudo` group.

Configured in `nopasswd-sudo`.

### 2. Faster disk access for ext3 and ext4
Provides two optimizations:
* Eliminates tracking of file and directory access time, since it's rarely used and can provide a noticeable speed gain especially in older hardware (ext2 and ext4).
* Changes ext4 data mode to writeback, which is thought to accelerate disk access.

Implemented as a root script in `speed-disk.sh`.

### 3. Reduce swapping
Eliminate excessive disk swapping.

Configured in `80-minswp-sysctl.conf`. After installing, run `sudo sysctl --system` to apply the settings immediately.

### 4. No IPv6
Disables the IPv6 stack, since my ISP does not (yet) offer IPv6. This provides a negligeable speed up for networking programs, and frees up a few extra bytes of memory.

Many programs, including web browsers, attempt first to establish IPv6 connections if the stack is enabled. Since the ISP modem is only IPv4, this initial attempt always fails, and the program falls back to IPv4. Without the IPv6 stack, this initial attempt is eliminated.

Implemented as a root script in `no-ipv6.sh`.

### 5. Faster DNS (and network)
Changes default DNS servers, enables DNS caching, and adds domain filters.

I opted to not use my ISP default DNS services. I ran empirical tests to select the DNS servers using:
~~~
	time nslookup <domain> <dns-server-ip>
~~~

The best DNS servers depend on your location. So, you want to time different providers. My ISP DNS was significantly slow, even when compared to DNS servers across the Pacific ocean.

Configured in `network.conf` and `nxdomains`, and implemented in `speed-net.sh`.

**IMPORTANT**. The **/etc/hosts** file is not used. I decided to not use it for consistency with the default system installation that disregards the hosts file. Would a different behavior be desired, the hosts lookup can be enabled in network.conf.

### 6. Remove cluter
Uninstalls unnecessary services and fonts. These include bluetooth, cups (printing), sane (scanners), avahi (certain network services), and thunderbird (desktop email).

Implemented as root scripts in `purge-services.sh` and 'purge-packages.sh`.

### 7. Installed additional packages
Added software and fonts, including traceroute, whois, and font-manager.

Implemented as a root script in `add-extra-packagesl.sh`

### 6. Tweaked Nano
Fixed mouse, smooth scrolling, line number in status bar, no help line, and no syntax highlinghting. 

Configured in `nanorc`.

**IMPORTANT**. INSTALL.sh installs the new nano configuration for all users. This makes it consistent for my unprivileged user and the root user. If only a single user configuration is preferred, manually copy the configuration file to ~/.nanorc instead. 

### 7. Tweaked bash terminal
Simplified the prompt, eliminated colors, tweaked aliases, and configured my development environment.

Configured in `bashrc`.


## Manual Configuration

### 1. Sudo without password
Add self to the sudo group.

### 2. Disable additional fonts
Run `font-manager` to disable unwanted fonts that could not be removed.

### 3. Optimize Firefox
Firefox preloads linked domain names and pages. This is expected to make following a subsequent link instantaneous, but it also bogs down bandwidth, preloads undesired (and sometimes undesirable) content, and generates misleading server hits (e.g. for content recommenders).

To disable, enter `about:config` in the address bar of Firefox. Agree to the warning.

Then, in the filter box below the address bar:
	* Type `ipv6` and change the entry `network.dns.disableIPv6` in the list to `true` (double-click the entry to change the value).
	* Type `predictor`; change `network.predictor.enabled` to `false`.
	* Type `prefetch`; change `network.prefetch-next` to `false` and `network.dns.disablePrefetch` to `true`.
	* Type `pipelining` and disable `network.http.pipelining`.

### 4. Install Google talk plugin
Install google-talkplugin by visiting gmail or g+.

### 5. Auto-save the session on exit
Use Accessories/gconf-editor and change the desktop session to auto-save on exit.


## License

MIT license. See the LICENSE file for details. 



