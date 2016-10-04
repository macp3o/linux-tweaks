# Linux Tweaks

*Optimizing Ubuntu, Mint, and other Debian-based systems.*

## Introduction

The tweaks optimize disk access, networking, memory swapping, video playback, usability, and more for Ubuntu, Mint, or other Debian-based systems.

The fixes are particularly beneficial for older and slower systems with limited memory.

## Installation
#### Quick setup

To install *all* automated tweaks, run from a terminal prompt:
~~~bash
	$  chmod u+x INSTALL.sh
	$  ./INSTALL.sh
~~~

Then, go to the Manual Settings to apply all manual settings.

**Warning**. `INSTALL.sh` removes several services and programs that are typically preinstalled in a new system installation.

#### Custom setup
To selectively apply *specific tweaks*, run the specific scripts or copy the configuration files included to the location indicated near the top of each file. All scripts, except for INSTALL.sh, must be run as root (e.g. with `sudo`).
 

#### Requirements

* Debian-based desktop/laptop system, including Ubuntu and Mint.
* Apply immediately after a fresh install, or prior configuration may be lost.
* For RHEL-based desktop/laptop systems, the customizations require manual adjustments.


## Features

#### 1. Sudo without password
Prevents sudo from asking for passwords from users belonging to the `sudo` group.

> Configured in `nopasswd-sudo`.

#### 2. Faster disk access for ext3 and ext4
Eliminates tracking of file and directory access time, since it's rarely used and can provide a noticeable speed gain especially in older hardware (ext2 and ext4).

Changes ext4 data mode to writeback, which is thought to accelerate disk access.

Updates udev with larger buffering, cfq scheduler, and no contribution to random. 

> Implemented as a root script in `speed-disk.sh` and 99-speed-disk.rules.

#### 3. Reduced memory swapping
Eliminates excessive memory swapping to disk.

> Configured in `80-minswp-sysctl.conf`. After installing, run `sudo sysctl --system` to apply the settings immediately.

#### 4. No IPv6
Disables the IPv6 stack, since my ISP does not (yet) offer IPv6. This provides a negligeable speed up for networking programs, and frees up a few extra bytes of memory.

> Many programs, including web browsers, attempt first to establish IPv6 connections if the stack is enabled. Since the ISP modem is only IPv4, this initial attempt always fails, and the program falls back to IPv4. Without the IPv6 stack, this initial attempt is eliminated.

> Implemented as a root script in `no-ipv6.sh`.

#### 5. Faster DNS and networking
Changes default DNS servers, enables DNS caching, and adds domain filters.

You have to `time` different DNS providers and adjust accordingly the settings in `network.conf` to select the most appropriate DNS service. To `time` a service, use:
~~~bash
	$  time nslookup <domain> <dns-server-ip>
~~~

> I ran empirical tests to select the DNS servers in the configuration file, but the right settings depend on the location of the computer and the specific ISP. So, you want to `time` different DNS providers. My ISP DNS was significantly slow, even when compared to DNS services across the Pacific ocean.

> Configured in `network.conf` and `nxdomains`, and implemented in `speed-net.sh`.

**Important**. `/etc/hosts` is not used to keep the system consistent with the default installation of NetworkManager. Would a different behavior be desired, the hosts lookup can be enabled in `network.conf`.

#### 6. Decluttering
Uninstalls unnecessary services and fonts. These include bluetooth, cups (printing), sane (scanners), avahi (certain network services), and thunderbird (desktop email).

> Implemented as root scripts in `purge-services.sh` and 'purge-packages.sh`.

#### 7. Additional packages
Adds software and fonts, including traceroute, whois, and font-manager.

> Implemented as a root script in `add-extra-packages.sh`

#### 6. Nano
Fixes mouse, smooth scrolling, line number in status bar, no help line, and no syntax highlinghting for all users. 

`INSTALL.sh` installs the new nano configuration for all users, instead of locally for the current user alone. This approach makes nano behave consistently for both my unprivileged user and the root user (including under `sudo`). Would a single user configuration be preferred, manually copy the configuration file to ~/.nanorc instead. 

> Configured in `nanorc`.

#### 7. Bash
Simplifies the terminal prompt, eliminates colors, and tweaks aliases.

> Configured in `bashrc`.

#### 8. Firewall
Enables the firewall with default rules.

> Implemented in `INSTALL.sh`.


## Manual Settings

#### 1. Sudo without password
Add the current user to the `sudo` group.

#### 2. Fewer fonts
Run `font-manager` to disable unwanted fonts that could not be removed.

#### 3. Firefox
Enter `about:config` in the address bar of Firefox, and agree to the warning  that appears.

In the filter box below the address bar, type the filter keyword from the table below. Then, select the corresponding setting in the list, and change it's value to the  value shown in the table by double clicking on it. Repeat for each row.

|      | Filter          | Setting                                                | Value |                                                       |
| --- | -------------- | :---------------------------------------------: | :-------: | ----------------------------------------| 
| 1   | ipv6           | network.dns.disableIPv6              | true    | no IPv6 from my ISP              |
| 2   | predictor | network.predictor.enabled          | false   | no preloading linked pages |
| 3   | prefetch   | network.prefetch-next                  | false   | |
| 4   | prefetch   | network.dns.disablePrefetch      | true    | |
| 5   | pipelining | network.http.pipelining               | false   | multiple requests per connection |
| 6   | workers    | dom.workers.maxPerDomain        | 4   | few web workers                      |
| 7   | workers    | dom.workers.sharedWorkers.enabled | false | |
| 8   | zoom         | browser.zoom.updateBackgroundTabs | false | less UI freezes on zoom|
| 9   | webm        | media.webm.enabled | false | faster video playback|

The first setting disables IPv6 lookups. It does not make Firefox unnoticeably faster, but makes me feel better :)

Settings 2-4 turn off speculative preloading of domain names and pages that are linked from the current page. This is expected to make navigating to a subsequent link instantaneous. This is great, but has a downside: It bogs down bandwidth unnecessarily, can preload undesired (and sometimes undesirable) content, and generates misleading server hits (e.g. negatively affecting for content recommenders).

Setting 5 allows several requests to be sent to the server over a single connection. This is faster than establishing separate connections for each request.

Settings 6-7 limit web workers. Web workers were freezing the desktop UI by accessing the disk aggressively everytime I opened additional tabs. I initially faulted the disk cache, but after troubleshooting, I found that web workers were running disk intensive tasks. I started by disabling web workers, making Firefox became usable again. Howver, web workers are required in Firefox 49 to prevent crashes (Firefox 49.0 crashes with dom.workers,maxPerDomain set to 1). 

Setting 8 minimizes freezes to the UI after zooming in or out.

Setting 9 forces Firefox to not use Webm VP9 video, since it's not hardware optimized yet.

#### 4. Google Chrome web browser
Install the Google Chrome browser from https://www.google.com/chrome/browser/

#### 5. Google Talk plugin
Install the google-talk plugin by visiting gmail or g+.

#### 6. Auto-save the session on exit
Run gconf-editor from the menu Accessories, and change the desktop session to auto-save on exit.

#### 7. Accelerate Adobe Flash Video
Adobe disabled GPU access in Flash for certain video cards to protect against potential security vulnerabilities. This script reenables access to the GPU.

To enable for a single user, run:
~~~bash
	$  echo OverrideGPUValidation=true >> ~/.adobe/mms.cfg
~~~

To enable globally for all users, run as root:
~~~bash
	$  mkdir -p /etc/adobe
	$  cat >> /etc/adobe/mms.cfg <<< OverrideGPUValidation=true
~~~

**Warning**: This may introduce a security vulnerability when running Adobe Flash.

## Recurring Tasks
#### Update domain filters
1. Add domains to `nxdomains`
2. Run as root: `speed-net.sh`


## License

Licensed under the [MIT License](LICENSE.md). 



