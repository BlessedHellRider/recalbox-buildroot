################################################################################
#
# Zelda Solarus dx Datas
#
################################################################################
ZELDASOLARUSDX_VERSION = 1.10.1
ZELDASOLARUSDX_SOURCE = zsdx-$(ZELDASOLARUSDX_VERSION).tar.gz
ZELDASOLARUSDX_SITE = https://github.com/christopho/zsdx/archive
ZELDASOLARUSDX_LICENCE = GPL
ZELDASOLARUSDX_DEPENDENCIES = 

define ZELDASOLARUSDX_RPI_FIXUP.in
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/CMakeLists.txt
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/CMakeLists.txt
endef

ZELDASOLARUSDX_PRE_CONFIGURE_HOOKS += ZELDASOLARUSDX_RPI_FIXUP

# Just copy the Data in a subdirectory of solaris
define ZELDASOLARUSDX_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/games/solarus/zsdx
	$(INSTALL) -D $(@D)/*.* \
		$(TARGET_DIR)/usr/games/solarus/zsdx
endef

$(eval $(cmake-package))
