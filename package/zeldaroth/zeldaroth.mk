################################################################################
#
# Zelda Roth
#
################################################################################
ZELDAROTH_VERSION = linux
ZELDAROTH_SOURCE = ZeldaROTH-src-$(ZELDAROTH_VERSION).tar.gz
ZELDAROTH_SITE = http://www.zeldaroth.fr/fichier/ROTH/pandora
ZELDAROTH_LICENCE = GPL
ZELDAROTH_DEPENDENCIES = 

define ZELDAROTH_RPI_FIXUP.in
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/CMakeLists.txt
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/CMakeLists.txt
endef

ZELDAROTH_PRE_CONFIGURE_HOOKS += ZELDAROTH_RPI_FIXUP

# Just copy the Data in a subdirectory of solarus
#define ZELDAROTH_INSTALL_TARGET_CMDS
#	mkdir -p $(TARGET_DIR)/usr/games/ZeldaROTH
#	$(INSTALL) -D $(@D)/*.* \
#		$(TARGET_DIR)/usr/games/ZeldaROTH
#endef

$(eval $(cmake-package))
