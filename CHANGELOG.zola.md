# Changelog

Describes changes between upstream `nerves_system_bbb` and `nerves_system_c2`.

## v2.15.1+zola-4

* Backport uBoot 2018.7
* Use nerves_toolchain 1.4.2 for compatibility with linux 4.19

## v2.15.1+zola-3

* Backport linux 4.19
* Set bb.org-overlays@@8085119c8940312853590c3394c591b8a20388cf

## v2.15.1+zola-2

* Rebase on top of v2.15.1

## v2.9.0+zola-2

* buildroot: add tcpdump, nftables
* busybox: add ping

## v2.9.0+zola-1

* linux: add modules can, bluetooth, serial-omap
* linux: remove serial 8250
* buildroot: add iproute2, ifconfig, can-util, bluez, pppd
* busybox: add which, tr, chmod, uname
* device tree: add BB-ZOLA-GATEWAY overlay
* test: add firmware test with pin mux tests