################################################################################
#
# fwup
#
################################################################################

FWUP_NEXT_VERSION = 1.10.1-pre
FWUP_NEXT_SITE = $(call github,jeanparpaillon,fwup,v$(FWUP_VERSION))
FWUP_NEXT_LICENSE = Apache-2.0
FWUP_NEXT_LICENSE_FILES = LICENSE
FWUP_NEXT_DEPENDENCIES = host-pkgconf libconfuse libarchive
HOST_FWUP_NEXT_DEPENDENCIES = host-pkgconf host-libconfuse host-libarchive
FWUP_NEXT_AUTORECONF = YES
FWUP_NEXT_CONF_ENV = ac_cv_path_HELP2MAN=""

$(eval $(autotools-package))
$(eval $(host-autotools-package))
