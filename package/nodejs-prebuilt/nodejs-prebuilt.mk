################################################################################
#
# nodejs
#
################################################################################

NODEJS_PREBUILT_VERSION = 14.17.1

NODEJS_PREBUILT_ARCH = armv7l
NODEJS_PREBUILT_SOURCE = node-v$(NODEJS_PREBUILT_VERSION)-linux-$(NODEJS_PREBUILT_ARCH).tar.xz
NODEJS_PREBUILT_SITE = http://nodejs.org/dist/v$(NODEJS_PREBUILT_VERSION)
NODEJS_PREBUILT_LICENSE = MIT (core code); MIT, Apache and BSD family licenses (Bundled components)
NODEJS_PREBUILT_LICENSE_FILES = LICENSE
NODEJS_PREBUILT_DEPENDENCIES = 

define NODEJS_PREBUILT_BUILD_CMDS
	true
endef

define NODEJS_PREBUILT_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/opts/nodejs
	mkdir -p $(TARGET_DIR)/opt/nodejs
	cp -a $(@D)/* $(TARGET_DIR)/opt/nodejs/
endef

$(eval $(generic-package))
