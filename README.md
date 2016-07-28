# BeagleBone Black

[![Build Status](https://travis-ci.org/nerves-project/nerves_system_bbb.png?branch=master)](https://travis-ci.org/nerves-project/nerves_system_bbb)

This is the base Nerves System configuration for the [BeagleBone Black](http://beagleboard.org/black).

![BeagleBone Black image](assets/images/beaglebone-black.png)
<br><sup>[Image credit](#fritzing)</sup>

| Feature              | Description                     |
| -------------------- | ------------------------------- |
| CPU                  | 1 GHz ARM Cortex-A8             |
| Memory               | 512 MB DRAM                      |
| Storage              | 4 GB eMMC Flash and MicroSD         |
| Linux kernel         | 4.4.9 w/ BBB patches |
| IEx terminal         | ttyS0 via FTDI pins |
| GPIO, I2C, SPI       | Yes - Elixir ALE            |
| ADC                  | Yes                             |
| PWM                  | Yes, but no Elixir support      |
| UART                 | ttyS0 + more via device tree overlay  |
| Camera               | None                            |
| Ethernet             | Yes    |
| WiFi                 | Requires USB WiFi dongle        |

## Console access

The console is configured to output to `ttyS0` by default. This is the
UART output accessible by the 6 pin header labeled J1. A 3.3V FTDI
cable is needed to access the output.

The HDMI output has been disabled via device tree to free up pins on the
GPIO header. If you would like console access via HDMI, you will need
to enable HDMI support in the Linux kernel, remove the HDMI disable
argument in the uboot script providing kernel arguments, and change
`erlinit.conf` to output to `tty1`.

## Linux versions

The BeagleBone Black has many options for Linux that vary by
kernel version and patch set. Nerves tracks those maintained by
Robert Nelson at https://eewiki.net/display/linuxonarm/BeagleBone+Black.
His patch sets have `-rt` and `-ti`/`-bone` options. The `-rt` for real-time
actually refers to `CONFIG_PREEMPT` and a couple other real-time options being
configured in the Linux kernel. Nerves uses those options as well. Nerves
follows the `-ti` patch set. See `nerves_system_br/boards/bbb` for the actual
patches.

Be aware that if you have been using Linux kernel 3.8 on the BeagleBone, that there
have been device tree overlay and PRU updates. File paths have changed for
inserting device tree overlays.

## Device tree overlays

Most pins on the BBB's headers are configurable via the device tree.
Configuration can be done at runtime via the [Universal I/O](https://github.com/cdsteinkuehler/beaglebone-universal-io)
device tree overlays. These overlays are included in the kernel configuration
for Nerves so you do not need to compile that project. Additionally, the
`config-pin` script is available in `/usr/bin` on the target. It has
minor modifications to run on Nerves.

### Universal I/O

The universal I/O overlays can be loaded manually or by using the `config-pin`
shell script:

```
iex(demo@nerves-0099)> :os.cmd('config-pin overlay cape-universaln')
'Loading cape-universaln overlay\n'
iex(demo@nerves-0099)> :os.cmd('config-pin -i P9_16') |> IO.puts
Pin name: P9_16
Function if no cape loaded: gpio
Function if cape loaded: default gpio gpio_pu gpio_pd pwm
Function information: gpio1_19 default gpio1_19 gpio1_19 gpio1_19 ehrpwm1B
Cape: cape-universala cape-universal cape-universaln
Kernel GPIO id: 51
PRU GPIO id: 83

:ok
iex(demo@nerves-0099)> :os.cmd('config-pin P9_16 pwm')
```

### ADCs

The following example shows how to read values from the 7 ADC inputs in Elixir.

```
iex(demo@nerves-0099)> File.write("/sys/devices/platform/bone_capemgr/slots","BB-ADC")
:ok
iex(demo@nerves-0099)> ls "/sys/bus/iio/devices/iio:device0"
buffer              dev                 in_voltage0_raw     in_voltage1_raw
in_voltage2_raw     in_voltage3_raw     in_voltage4_raw     in_voltage5_raw
in_voltage6_raw     name                of_node             power
scan_elements       subsystem           uevent
iex(demo@nerves-0099)> File.read("/sys/bus/iio/devices/iio:device0/in_voltage0_raw")
{:ok, "3891\n"}
iex(demo@nerves-0099)> File.read("/sys/bus/iio/devices/iio:device0/in_voltage0_raw")
{:ok, "3890\n"}
iex(demo@nerves-0099)> File.read("/sys/bus/iio/devices/iio:device0/in_voltage0_raw")
{:ok, "3891\n"}
```

### SPI

The following examples shows to read values from the SPIs inputs in Elixir.

```
iex(demo@nerves-0099)> File.write("/sys/devices/platform/bone_capemgr/slots","BB-SPIDEV0")
:ok
iex(demo@nerves-0099)> File.write("/sys/devices/platform/bone_capemgr/slots","BB-SPIDEV1")
:ok
iex(demo@nerves-0099) ls "/dev"
  ...
                    pts                 random                    shm              spidev1.0
              spidev1.1              spidev2.0              spidev2.1                    tty
  ...
iex(demo@nerves-0099) File.read "/sys/bus/spi/devices/spi1.0/statistics/transfers"
{:ok, "0"}
```

## Supported USB WiFi devices

The base image includes drivers and firmware for Ralink RT53xx
(`rt2800usb` driver) and RealTek RTL8712U (`r8712u` driver) devices.

We are still working out which subset of all possible WiFi dongles to
support in our images. At some point, we may have the option to support
all dongles and selectively install modules at packaging time, but until
then, these drivers and their associated firmware blobs add significantly
to Nerves release images.

If you are unsure what driver your WiFi dongle requires, run Raspbian and configure WiFi
for your device. At a shell prompt, run `lsmod` to see which drivers are loaded.
Running `dmesg` may also give a clue. When using `dmesg`, reinsert the USB
dongle to generate new log messages if you don't see them.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add nerves_system_bbb to your list of dependencies in `mix.exs`:

        def deps do
          [{:nerves_system_bbb, "~> 0.4.0"}]
        end

  2. Ensure nerves_system_bbb is started before your application:

        def application do
          [applications: [:nerves_system_bbb]]
        end


[Image credit](#fritzing): This image is from the [Fritzing](http://fritzing.org/home/) parts library.
