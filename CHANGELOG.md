# Changelog

## v2.5.0

This release updates Buildroot to 2019.11 with security and bug fix updates
across Linux packages. Enables dnsd, udhcpd and ifconfig in the default 
Busybox configuration to support `vintage_net` and `vintage_net_wizard`. 
See the `nerves_system_br` notes for details.

* Updated dependencies
  * [nerves_system_br v1.10.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.10.0)
  * Erlang 22.1.8
  * Linux 4.19.72 with the Beagleboard Debian kernel patches

## v2.4.2

This release updates Buildroot to 2019.08.2 with security and bug fix updates
across Linux packages. See the `nerves_system_br` notes for details.
Erlang/OTP is now at 22.1.7.

This release also enables the pinmux helper for changing the pin settings on
the PocketBeagle and other boards.

For example:

```bash
iex> cat "/sys/devices/platform/ocp/ocp:P2_30_pinmux/state"
default
iex> File.write("/sys/devices/platform/ocp/ocp:P2_30_pinmux/state", "spi_cs")
:ok
```

For the PocketBeagle, see
https://github.com/beagleboard/linux/blob/4.19/arch/arm/boot/dts/am335x-pocketbeagle.dts#L1186

* Updated dependencies
  * [nerves_system_br v1.9.5](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.9.5)

## v2.4.1

This release pulls in security and bug fix updates from `nerves_system_br`.
Erlang/OTP is now at 22.1.1.

* Updated dependencies
  * [nerves_system_br v1.9.4](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.9.4)
  * bborg-overlays - update to latest to pull in device tree overlay fixes and
    additions from upstream

## v2.4.0

This release updates Buildroot to 2019.08 with security and bug fix updates
across Linux packages. See the `nerves_system_br` notes for details.

* Updated dependencies
  * [nerves_system_br v1.9.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.9.2)

* Enhancements
  * Support a variety of USB->UART adapters so more devices work out-of-the-box

## v2.3.2

This release fixes an issue where the MAC address for the wired Ethernet port on
many BeagleBone-based boards was not being set. Unfortunately, the fix is with
the U-Boot bootloader configuration and this is not updated when applying
updates over-the-air. Fresh firmware installs will apply the fix, so if you're
burning MicroSD cards, you're fine. It is possible to fix the wired Ethernet MAC
address issue in the field if necessary. Please post to our support channels if
you need to do this and are not sure.

* Updated dependencies
  * [nerves_system_br v1.8.5](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.8.5)
  * Linux 4.19.50

## v2.3.1

* Enhancements
  * Enable source-based routing in the Linux kernel to support [vintage_net](https://github.com/nerves-networking/vintage_net)
  * Enable pstore, an in-memory buffer that can capture logs, kernel
    oops and other information when unexpected reboots. The buffer can be
    recovered on the next boot where it can be inspected.

* Updated dependencies
  * [nerves_system_br v1.8.4](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.8.4)

## v2.3.0

This release

This release updates Erlang to OTP 22 and gcc from version 7.3.0 to 8.3.0.
See the nerves_system_br and toolchain release notes for more information.

* Enhancements
  * Enable source-based routing in the Linux kernel to support [vintage_net](https://github.com/nerves-networking/vintage_net)

* Updated dependencies
  * Erlang 22.0.4
  * [nerves_system_br v1.8.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.8.2)
  * [nerves_toolchain_arm_unknown_linux_gnueabihf v1.2.0](https://github.com/nerves-project/toolchains/releases/tag/v1.2.0)

## v2.2.2

* Bux fixes
  * Add TAR option `--no-same-owner` to fix errors when untarring artifacts as
    the root user.
* Updated dependencies
  * [nerves_system_br v1.7.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.7.2)

## v2.2.1

* Bug fixes
  * Re-enabled Ralink rt2800usb WiFi driver.

* Improvements
  * Bump C compiler options to `-O2` from `-Os`. This provides a small, but
    measurable performance improvement (500ms at boot in a trivial project
    tested on [nerves_system_rpi0](https://github.com/nerves-project/nerves_system_rpi0)).
  * Added r8712u.ko WiFi driver.

* Updated dependencies
  * [nerves_system_br v1.7.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.7.1)

## v2.2.0

 * Updated dependencies
  * [nerves_system_br v1.7.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.7.0)
  * Erlang 21.2.7
  * Linux 4.19.26 with the Beagleboard Debian kernel patches

## v2.1.3

 * Updated dependencies
  * [nerves_system_br v1.6.8](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.8)
  * Erlang 21.2.6

## v2.1.2

* Updated dependencies
  * [nerves_system_br v1.6.6](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.6)
  * Erlang 21.2.4
  * boardid 1.5.3

## v2.1.1

* Updated dependencies
  * [nerves_system_br v1.6.5](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.5)
  * Erlang 21.2.2
  * boardid 1.5.2
  * erlinit 1.4.9
  * OpenSSL 1.1.1a
  * Linux 4.19.10 with the Beagleboard Debian kernel patches

* Enhancements
  * Moved boardid config from inside erlinit.config to /etc/boardid.config

## v2.1.0

This pulls in a pending patch in Buildroot to update the version of
OpenSSL from 1.0.2 to 1.1.0h. This fixes what appears to be issues with
Erlang using OpenSSL engines. It also enables Erlang crypto algorithms
such as ed25519 that have been added in recent Erlang releases.

* Updated dependencies
  * [nerves_system_br v1.6.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.1)
  * Erlang 21.2
* Added dependencies
  * wpa_passphrase
  * libp11 0.4.9

## v2.0.0

* Enhancements
  * Enable `AM335X-PRU-UIO-00A0` device tree overlay for PRU support.
    See the [README.md](https://github.com/nerves-project/nerves_system_bbb/README.md#prus) for more information.
* Updated dependencies
  * [nerves_system_br v1.5.3](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.5.3)

## v2.0.0-rc.0

This is a backwards incompatible update to `nerves_system_bbb`. Over-the-air
updates to existing devices will not work. If you're a production user of
`nerves_system_bbb`, please consider supporting efforts to maintain a v1.4.0
branch.

The v2.0.0 support adds the following:

1. Device tree overlays are applied by U-Boot now. Support in Nerves is nearly
   identical to Beagleboard.org's Debian distribution. This fixes significant
   issues in v1.4.0 and before ever since upstream moved from loading device
   tree overlays in Linux to U-Boot.
2. Support for automatic failback of bad new builds. If enabled, your Nerves
   application will need to mark a software update as good (for example, it can
   contact a server) or else the next reboot will revert.
3. The application partition uses F2FS rather than EXT4. This noticeably
   improves startup time on the first boot and has some less obvious advantages
   from being a Flash-aware file system.
4. The hardware watchdog is enabled at boot. Your application must enable
   `heart` now.
5. The U-Boot environment was increased in size to 128 KB. This was required for
   the new device tree overlay support and unfortunately makes migrating devices
   from v1.4.0 not possible without significant work.


* Updated dependencies
  * [nerves_system_br v1.5.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.5.2)
  * Linux 4.18.9 + The Beagleboard Debian kernel patches
  * Erlang 21.0.9

## v1.4.0

This release contains various updates to provisioning variables and data.

**Host requirements**

Building firmware using this system requires `fwup` to be updated on your
host computer to at least `v1.2.5`. The target minimum version requirement
has not changed from `0.15.0`.

**Serial numbers**

Device serial numbers are now set using `NERVES_SERIAL_NUMBER` instead of
`SERIAL_NUMBER`. This is to reduce ambiguity on the source of the serial
by name spacing it along side other Nerves variables. The U-Boot environment
key has also changed from `serial_number` to `nerves_serial_number`. The
erlinit.config has been updated to provide backwards compatibility for setting
the hostname from the serial number by checking for `nerves_serial_number`
and falling back to `serial_number`.

**Custom provisioning**

Provisioning data is applied at the time of calling the `fwup` task `complete`.
The `complete` task is executed when writing the firmware to the target disk.
During this time, `fwup` will include the contents of a provisioning file
located at `${NERVES_SYSTEM}/images/fwup_include/provisioning.conf`. By default,
this file only sets `nerves_serial_number`. You can add additional provisioning
data by overriding the location of this file to include your own by setting
the environment variable `NERVES_PROVISIONING`. If you override this variable
you will be responsible for also setting `nerves_serial_number`.

* Updated dependencies
  * [nerves_system_br v1.4.5](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.4.5)

## v1.3.0

This release upgrades gcc from version 6.3.0 to 7.3.0. See the toolchain release
notes for more information.

Switch to using busybox.fragment for easier maintainance.

* Updated dependencies
  * [nerves_system_br v1.4.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.4.1)
  * [nerves_toolchain_arm_unknown_linux_gnueabihf v1.1.0](https://github.com/nerves-project/toolchains/releases/tag/v1.1.0)

## v1.2.1

* Updated dependencies
  * [nerves_system_br v1.3.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.3.2)

## v1.2.0

This release updates Erlang to OTP 21.0

* Updated dependencies
  * [nerves_system_br v1.3.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.3.0)

## v1.1.1

This release fixes some issues and adds firmware UUID support. This support can
be used to unambiguously know what's running on a device.

* Updated dependencies
  * [nerves_system_br v1.2.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.2.2)

* Bug fixes
  * Empty serial numbers stored in the U-Boot environment would be used instead
    of reverting to devices IDs built into the CPU or board.
  * It wasn't possible to enable QtWebEngine (needed for kiosk apps)

## v1.1.0

This release adds official support for provisioning serial numbers to devices.
Other information can be provisioned in a similar manner. See the README.md for
details.

Buildroot was also updated to 2018.05. Be sure to review the `nerves_system_br`
link for the changes in the embedded Linux components.

* Updated dependencies
  * [nerves_system_br v1.2.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.2.0)

* New features
  * More `wpa-supplicant` features were enabled to support more WiFi use-cases

## v1.0.0

This release is nearly identical to rc.1 except with the deps bump to 1.0 and
documentation/comment updates.

* Updated dependencies
  * [nerves_system_br v1.0.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.0.0)
  * [nerves_toolchain v1.0.0](https://github.com/nerves-project/toolchains/releases/tag/v1.0.0)
  * [nerves v1.0.0](https://github.com/nerves-project/nerves/releases/tag/1.0.0)

## v1.0.0-rc.1

This release contains updates to Erlang and heart from `nerves_system_br`. It
also has a configuration change to the Linux kernel that enables scaling the
processor frequency based on workload. This makes the process run much cooler
while still allowing it to increase frequency for heavy computations.

Note that the trivial `.fw` files are no longer created by CI scripts. If you've
forked this project and are building systems using CI, make sure to update your
publish scripts.

* Updated dependencies
  * [nerves_system_br v1.0.0-rc.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.0.0-rc.2)
  * Linux 4.4.113 w/ RCN's patches

## v1.0.0-rc.0

* Updated dependencies
  * [nerves_system_br v1.0.0-rc.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.0.0-rc.0)
  * [nerves_toolchain v1.0.0-rc.0](https://github.com/nerves-project/toolchains/releases/tag/v1.0.0-rc.0)
  * [nerves v1.0.0-rc.0](https://github.com/nerves-project/nerves/releases/tag/1.0.0-rc.0)

## v0.20.0

* Updated dependencies
  * [nerves_system_br v0.17.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.17.0)
  * [nerves_toolchain v0.13.0](https://github.com/nerves-project/toolchains/releases/tag/v0.13.0)
  * [nerves v0.9.0](https://github.com/nerves-project/nerves/releases/tag/v0.9.0)

## v0.19.1

* Updated dependencies
  * [nerves_system_br v0.16.3](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.16.3)
    This fixes the call to otp_build so that it always uses Buildroot's version
    the autoconf tools.

## v0.19.0

* Updated dependencies
  * [nerves_system_br v0.16.1-2017-11](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.16.1-2017-11)

* Enhancements
  * Reboot automatically if Erlang VM exits - This is consistent with other
    Nerves systems. See rootfs_overlay/etc/erlinit.config if undesired.
  * Start running nerves_system_linter to check for configuration errors.
  * Automount the boot partition readonly at `/boot`
  * Support for reverting firmware.

    See [Reverting Firmware](https://hexdocs.pm/nerves_runtime/readme.html#reverting-firmware) for more info on reverting firmware.

    See [fwup-revert.conf](https://github.com/nerves-project/nerves_system_rpi/blob/master/fwup-revert.conf) for more information on how fwup handles reverting.

## v0.18.0

* Updated dependencies
  * [nerves_system_br v0.15.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.15.0)
  * [toolchain v0.12.1](https://github.com/nerves-project/toolchains/releases/tag/v0.12.1)
  * u-boot 2017.09
  * Linux 4.4.91 w/ RCN's patches

* Enhancements
  * Support for nerves 0.8. Moves nerves.exs into mix.exs
  * Support for pocketbeagle

* Bug Fixes
  * Clear out the wl18xx MAC address field
    This will trigger the WiLink device driver to use the MAC address that
    TI programmed into the module rather than 00:00:de:ad:be:ef.

## v0.17.1

* Updated dependencies
  * [nerves_system_br v0.14.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.14.1)

## v0.17.0

This release changes the default IEx prompt output from the debug UART pins
to a virtual serial port on the USB OTG connector. This release also enables
a virtual Ethernet interface on the same USB interface for software updates.
See the `nerves_init_gadget` project for initialization code.

* Updated dependencies
  * [nerves_system_br v0.14.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.14.0)
    * [Buildroot 2017.08](https://git.busybox.net/buildroot/plain/CHANGES?id=2017.08)
    * [fwup 0.17.0](https://github.com/fhunleth/fwup/releases/tag/v0.17.0)
    * [erlinit 1.2.0](https://github.com/nerves-project/erlinit/releases/tag/v1.2.0)
    * [nbtty 0.3.0](https://github.com/fhunleth/nbtty/releases/tag/v0.3.0)

* Enhancements
  * Add global patch directory

  This is required to pull in the e2fsprogs patch that's needed now that
  util-linux's uuid_generate function calls getrandom and can block
  indefinitely for the urandom pool to initialize

* Bug Fixes
  * Use `nbtty` by default to fix tty hang issue

## v0.16.1

* Updated dependencies
  * nerves_system_br v0.13.7

## v0.16.0

This release contains an updated toolchain with Linux 4.1 Headers.
You will have to clean and compile any c/c++ code in your project and
dependencies. Failure to do so will result in an error when producing firmware.

* nerves_system_br v0.13.5
  * fwup 0.15.4

* Nerves toolchain v0.11.0

## v0.15.0

* nerves_system_br v0.13.3
  * erlinit 1.1.4

* New features
  * Firmware updates verify that they're updating the right target. If the target
    doesn't say that it's an `bbb` through the firmware metadata, the update
    will fail.
  * Added meta-misc and meta-vcs-identifier to the `fwup.conf` metadata for use
    by users and for the regression test framework
  * Use String.trim instead of String.strip to silence Elixir 1.5 warnings

## v0.14.0

* nerves_system_br v0.13.2
  * OTP 20
  * erlinit 1.1.3
  * fwup 0.15.3

## v0.13.0

This release is NOT backwards compatible with previous releases and will not
upgrade old systems. With work, it is possible to upgrade old systems, but it is
not recommended.

* nerves_system_br v0.12.1
  * erlinit 1.1.1
  * fwup 0.15.0

* New features
  * The application data partition is now `ext4`. This greatly improves its
    robustness to corruption. Nerves.Runtime contains code to initialize it on
    first boot.
  * Firmware images now contain metadata that can be queried at runtime (see
    Nerves.Runtime.KV
  * The boot partition is managed in an A/B style to support more robust
    firmware updates.

* Bug fixes
  * The Linux kernel is no longer compiled for SMP. All Beaglebone variants
    are single processor.

NOTE: It is possible to support "failback" operation of firmware updates with
the BBB. I.e. if an partition doesn't boot, the system reverts to the previous
one. This is not implemented here, but this system is being made to align more
with implementations that do this to make the transition easier.

## v0.12.0

* nerves_system_br v0.10.0
  * Buildroot 2017.02
  * Erlang/OTP 19.3

* New features
  * Support for BBG Wireless - the BBGW's MAC Address is not automatically set
    so support needs to be added. However, one BBGW on a WLAN works.
  * Bump Linux kernel to 4.4.60

## v0.11.0

* New Features
  * Support for Nerves 0.5.0

## v0.10.0

* New features
  * Bump toolchain to use gcc 5.3 (previously using gcc 4.9.3)
  * Bump Linux kernel to 4.4.43

## v0.9.0

This version switches to using the `nerves_package` compiler. This will
consolidate overall deps and compilers.

* Nerves.System.BR v0.8.1
  * Support for distillery
  * Support for nerves_package compiler

## v0.8.0

When upgrading to this version, be sure to review the updates to
nerves_defconfig. BR2_PACKAGE_ERLANG is no longer selected automatically and
must be added.

* nerves_system_br v0.7.0
  * Package updates
    * Buildroot 2016.08

  * Bug fixes
    * Many packages were removed. These include Elixir and LFE since neither are
      actually used. Both are added as part of the user build step, so no
      functionality is lost. The most visible result is that the system images
      are smaller and the test .fw file boots to the Erlang prompt.
    * Fix false positive from scrubber when checking executable formats due to
      C++ template instantiations. Ignores SYSV vs. GNU/Linux ABI difference.

## v0.7.1

* Package versions
  * Nerves.System.BR v0.6.1

* New features
  * Pull in BeagleBone Green updates (new u-boot, bbg device tree)

## v0.7.0

* Nerves.System.BR v0.6.0
  * Package updates
    * Erlang OTP 19
    * Elixir 1.3.1
    * fwup 0.8.0
    * erlinit 0.7.3
    * bborg-overlays (pull in I2C typo fix from upstream)
  * Bug fixes
    * Synchronize file system kernel configs across all platforms

## v0.6.2

* Bug Fixes
  * Enabled bbborg-overlays for universal device tree

## v0.6.1

* Nerves.System.BR v0.5.1
  * Bug Fixes(nerves-env)
    * Added include paths to CFLAGS and CXXFLAGS
    * Pass sysroot to LDFLAGS

## v0.6.0

* Nerves.System.BR v0.5.0
  * New features
    * WiFi drivers enabled by default on RPi2 and RPi3
    * Include wireless regulatory database in Linux kernel by default
      on WiFi-enabled platforms. Since kernel/rootfs are read-only and
      coupled together for firmware updates, the normal CRDA/udev approach
      isn't necessary.
    * Upgraded the default BeagleBone Black kernel from 3.8 to 4.4.9. The
      standard BBB device tree overlays are included by default even though the
      upstream kernel patches no longer include them.
    * Change all fwup configurations from two step upgrades to one step
      upgrades. If you used the base fwup.conf files to upgrade, you no
      longer need to finalize the upgrade. If not, there's no change.

## v0.5.0

* Nerves.System.BR v0.4.1
  * Bug fixes
    * syslinux fails to boot when compiled on some gcc 5 systems
    * Fixed regression when booting off eMMC on the BBB

  * Package updates
    * Erlang 18.3
    * Elixir 1.2.5
* Enhancements
  * Includes config-pin for controlling pin muxing. See [beaglebone-universal-io](https://github.com/cdsteinkuehler/beaglebone-universal-io)
