#############################################################
#
# extra-dts
#
#############################################################

# Remember to bump the version when anything changes in this
# directory.
EXTRA_DTS_SOURCE =
EXTRA_DTS_VERSION = 0.0.1
EXTRA_DTS_DEPENDENCIES = host-dtc

define EXTRA_DTS_BUILD_CMDS
	cp $(NERVES_DEFCONFIG_DIR)/package/extra-dts/*.dts* $(@D)
        for filename in $(@D)/*.dts; do \
            $(CPP) -I$(@D) -nostdinc -undef -D__DTS__ -x assembler-with-cpp $$filename | \
              $(HOST_DIR)/usr/bin/dtc -Wno-unit_address_vs_reg -@ -I dts -O dtb -b 0 -o $${filename%.dts}.dtbo || exit 1; \
        done
endef

define EXTRA_DTS_INSTALL_TARGET_CMDS
        cp $(@D)/*.dtbo $(TARGET_DIR)/lib/firmware
endef


$(eval $(generic-package))
