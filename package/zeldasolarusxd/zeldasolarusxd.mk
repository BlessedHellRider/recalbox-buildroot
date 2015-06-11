################################################################################
#
# Zelda Solarus xd Datas
#
################################################################################
ZELDASOLARUSXD_VERSION = 1.10.1
ZELDASOLARUSXD_SOURCE = zsxd-$(ZELDASOLARUSXD_VERSION).tar.gz
ZELDASOLARUSXD_SITE = https://github.com/christopho/zsxd/archive
ZELDASOLARUSXD_LICENCE = GPL
ZELDASOLARUSXD_DEPENDENCIES = 

define ZELDASOLARUSXD_RPI_FIXUP.in
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/CMakeLists.txt
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/CMakeLists.txt
endef

ZELDASOLARUSXD_PRE_CONFIGURE_HOOKS += ZELDASOLARUSXD_RPI_FIXUP

# Just copy the Data in a subdirectory of solarus
define ZELDASOLARUSXD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/games/solarus/zsxd
	$(INSTALL) -D $(@D)/*.* \
		$(TARGET_DIR)/usr/games/solarus/zsxd
endef

$(eval $(cmake-package))
