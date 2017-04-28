# Changelog

## v0.13.0-dev

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
    * Includes config-pin for controlling pin muxing. more info: https://github.com/cdsteinkuehler/beaglebone-universal-io
