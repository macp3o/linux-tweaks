# Debian System Tweaks

Settings tweaks to optimize disk access, networking, memory swapping, and usability, of Debian-based Linux systems, including Ubuntu and Mint,

The tweaks include:
* Customizations applied automatically by script, and
* Setting updates that require manual intervention.


## Installation

To install *all* automated tweaks, from a terminal prompt, run:
~~~bash
	$ chmod u+x INSTALL.sh
	$ ./INSTALL.sh
~~~

To apply *individual tweaks*, run the other scripts or copy the configuration files included to the location indicated near the top of each file. All scripts, except for INSTALL.sh, must be run as root (e.g. with `sudo`).
  
**WARNING**. It's important to note that `INSTALL.sh` removes several services and programs that are typically installed by fresh installations of the system.


## Requirements

* Debian-based desktop/laptop system, including Ubuntu and Mint.

> For RHEL-based desktop/laptop systems, the customizations require some adjustments.

* Apply preferrably immediately after a fresh install.

> Most of the tweaks can be applied successfully at a later time however, but no attempt is made to preserve any potential user changes.


## Features

#### 1. Sudo without password
Prevents sudo from asking for passwords from users belonging to the `sudo` group.

> Configured in `nopasswd-sudo`.

#### 2. Faster disk access for ext3 and ext4
* Eliminates tracking of file and directory access time, since it's rarely used and can provide a noticeable speed gain especially in older hardware (ext2 and ext4).

* Changes ext4 data mode to writeback, which is thought to accelerate disk access.

> Implemented as a root script in `speed-disk.sh`.

#### 3. Reduced memory swapping
Eliminate excessive memory swapping to/from disk.

> Configured in `80-minswp-sysctl.conf`. After installing, run `sudo sysctl --system` to apply the settings immediately.

#### 4. No IPv6
Disables the IPv6 stack, since my ISP does not (yet) offer IPv6. This provides a negligeable speed up for networking programs, and frees up a few extra bytes of memory.

> Many programs, including web browsers, attempt first to establish IPv6 connections if the stack is enabled. Since the ISP modem is only IPv4, this initial attempt always fails, and the program falls back to IPv4. Without the IPv6 stack, this initial attempt is eliminated.

> Implemented as a root script in `no-ipv6.sh`.

#### 5. Faster DNS and networking
Changes default DNS servers, enables DNS caching, and adds domain filters.

> I opted to not use my ISP default DNS services. I ran empirical tests to select the DNS servers using:
~~~bash
	$  time nslookup <domain> <dns-server-ip>
~~~

> The best DNS servers depend on how the computer connects to the Internet. So, you want to `time` different DNS providers. My ISP DNS was significantly slow, even when compared to DNS services across the Pacific ocean.

> Configured in `network.conf` and `nxdomains`, and implemented in `speed-net.sh`.

**IMPORTANT**. The **/etc/hosts** file is not used. I decided to not use it for consistency with the default system installation that disregards the hosts file. Would a different behavior be desired, the hosts lookup can be enabled in network.conf.

#### 6. Less clutter
Uninstalls unnecessary services and fonts. These include bluetooth, cups (printing), sane (scanners), avahi (certain network services), and thunderbird (desktop email).

> Implemented as root scripts in `purge-services.sh` and 'purge-packages.sh`.

#### 7. Additional packages
Adds software and fonts, including traceroute, whois, and font-manager.

> Implemented as a root script in `add-extra-packagesl.sh`

#### 6. Nano
Fixes mouse, smooth scrolling, line number in status bar, no help line, and no syntax highlinghting for all users. 

> `INSTALL.sh` installs the new nano configuration for all users. This makes it consistent for both my unprivileged user and the root user. Would a single user configuration be preferred, manually copy the configuration file to ~/.nanorc instead. 

> Configured in `nanorc`.

#### 7. Bash
Simplifies the terminal prompt, eliminates colors, tweaks aliases, and configures my development environment.

> Configured in `bashrc`.


## Manual Settings

#### 1. Sudo without password
Add self to the sudo group.

#### 2. Less fonts
Run `font-manager` to disable unwanted fonts that could not be removed.

#### 3. Firefox
Enter `about:config` in the address bar of Firefox, and agree to the scary warning  that appears.

In the filter box (below the address bar), type the filter keyword from the table below, select the corresponding setting in the list, and change it's value to the  value shown in the table by double clicking on it. Repeat for each row.

| Filter          | Setting                                         | Value |
| -------------- | :----------------------------------------: | :------: |
| ipv6           | network.dns.disableIPv6        | true   |
| predictor | network.predictor.enabled    | false  |
| prefetch   | network.prefetch-next             | false |
| prefetch   | network.dns.disablePrefetch | true  |
| pipelining | network.http.pipelining          | false |

> The first setting disables IPv6 lookups. It does not make Firefox unnoticeably faster, but makes me feel better :)

> The other settings turn off preloading of domain names and pages that are linked from the current page. This is expected to make following a subsequent link instantaneous, which is great. The downside is that it bogs down bandwidth, can preload undesired (and sometimes undesirable) content, and generates misleading server hits (e.g. negatively affecting for content recommenders).

#### 4. Google Talk plugin
Install google-talkplugin by visiting gmail or g+.

#### 5. Auto-save the session on exit
Run gconf-editor from the menu Accessories, and change the desktop session to auto-save on exit.


## License

MIT license. See the LICENSE file for details. 



