#############################################################
#
# bborg-overlays
#
#############################################################

BBORG_OVERLAYS_ZOLA_VERSION = 8085119c8940312853590c3394c591b8a20388cf
BBORG_OVERLAYS_ZOLA_SITE = $(call github,OffgridElectric,bb.org-overlays,$(BBORG_OVERLAYS_ZOLA_VERSION))
BBORG_OVERLAYS_ZOLA_LICENSE = GPLv2
BBORG_OVERLAYS_ZOLA_DEPENDENCIES = host-dtc

# See https://github.com/beagleboard/bb.org-overlays/blob/master/Makefile
# for preprocessing logic before invoking dtc
define BBORG_OVERLAYS_ZOLA_BUILD_CMDS
	for filename in $(@D)/src/arm/*.dts; do \
	    $(CPP) -I$(@D)/include -I$(@D)/src/arm -nostdinc -undef -D__DTS__ -x assembler-with-cpp $$filename | \
	      $(HOST_DIR)/usr/bin/dtc -Wno-unit_address_vs_reg -@ -I dts -O dtb -b 0 -o $${filename%.dts}.dtbo || exit 1; \
	done
endef

define BBORG_OVERLAYS_ZOLA_INSTALL_TARGET_CMDS
	cp $(@D)/src/arm/*.dtbo $(TARGET_DIR)/lib/firmware
endef

$(eval $(generic-package))