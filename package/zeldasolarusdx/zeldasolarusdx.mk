################################################################################
#
# Zelda Solarus dx
#
################################################################################
ZELDASOLARUSDX_VERSION = 1.4.1
ZELDASOLARUSDX_SOURCE = v$(ZELDASOLARUSDX_VERSION).tar.gz
ZELDASOLARUSDX_SITE = https://github.com/christopho/solarus/archive
ZELDASOLARUSDX_LICENCE = GPL
ZELDASOLARUSDX_DEPENDENCIES = libpthread-stubs sdl2 sdl2_image sdl2_ttf openal vorbis-tools modplugtools luajit physfs

define ZELDASOLARUSDX_RPI_FIXUP.in
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/CMakeLists.txt
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/CMakeLists.txt
endef

ZELDASOLARUSDX_PRE_CONFIGURE_HOOKS += ZELDASOLARUSDX_RPI_FIXUP

# Just copy the binary and lib, maybe we should copy more things after tests
define ZELDASOLARUSDX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/solarus_run \
		$(TARGET_DIR)/usr/games/zeldasolarusdx/solarus_run
	$(INSTALL) -D $(@D)/libsolarus.so \
                $(TARGET_DIR)/usr/games/zeldasolarusdx/libsolarus.so

endef

$(eval $(cmake-package))
