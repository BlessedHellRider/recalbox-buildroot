################################################################################
#
# Zelda Solarus dx Engine
#
################################################################################
SOLARUS_VERSION = 1.4.2-correctcommit
SOLARUS_SOURCE = v$(SOLARUS_VERSION).tar.gz
SOLARUS_SITE = https://github.com/christopho/solarus/archive
SOLARUS_LICENCE = GPL
SOLARUS_DEPENDENCIES = libpthread-stubs sdl2 sdl2_image sdl2_ttf openal vorbis-tools modplugtools luajit physfs

define SOLARUS_RPI_FIXUP.in
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/CMakeLists.txt
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/CMakeLists.txt
endef

SOLARUS_PRE_CONFIGURE_HOOKS += SOLARUS_RPI_FIXUP

# Just copy the binary and lib, maybe we should copy more things after tests
define SOLARUS_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/solarus_run \
		$(TARGET_DIR)/usr/games/solarus/solarus_run
	$(INSTALL) -D $(@D)/libsolarus.so \
                $(TARGET_DIR)/usr/games/solarus/libsolarus.so

endef

$(eval $(cmake-package))
