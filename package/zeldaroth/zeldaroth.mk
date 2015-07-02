################################################################################
#
# Zelda Roth
#
################################################################################
ZELDAROTH_VERSION = linux
ZELDAROTH_SOURCE = ZeldaROTH-src-$(ZELDAROTH_VERSION).tar.gz
ZELDAROTH_SITE = http://www.zeldaroth.fr/fichier/ROTH/pandora
ZELDAROTH_LICENCE = GPL

ZELDAROTH_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_gfx

ZELDAROTH_CFLAGS = -I$(STAGING_DIR)/usr/include -L$(STAGING_DIR)/usr/lib
ZELDAROTH_LDLIBS = -L$(STAGING_DIR)/usr/lib -lSDL_gfx -lSDL_image -lSDL_mixer -lSDL -lm

ZELDAROTH_PARAMS = VC=1 USE_GLES=1

ifeq ($(BR2_ARM_CPU_ARMV6),y)
        ZELDAROTH_PARAMS += VFP_HARD=1
	ZELDAROTH_HOST_CPU = armv6
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
        ZELDAROTH_PARAMS += NEON=1
	ZELDAROTH_HOST_CPU = armv7
endif

define ZELDAROTH_BUILD_CMDS
        $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CXX)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" CROSS_COMPILE="$(STAGING_DIR)/usr/bin/" \
        CFLAGS="$(TARGET_CFLAGS) $(ZELDAROTH_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS) $(ZELDAROTH_CFLAGS)" \
	PREFIX="$(STAGING_DIR)/usr/" \
	PKG_CONFIG="$(HOST_DIR)/usr/bin/pkg-config" \
	HOST_CPU="$(ZELDAROTH_HOST_CPU)" \
	LDFLAGS="$(TARGET_LDFLAGS) $(ZELDAROTH_LDLIBS)" \
	-C $(@D)/src ALL $(ZELDAROTH_PARAMS) OPTFLAGS="$(TARGET_CXXFLAGS)" 
endef

define ZELDAROTH_INSTALL_TARGET_CMDS
        mkdir -p $(TARGET_DIR)/usr/games/ZeldaROTH/
        $(INSTALL) -D $(@D)/src/ZeldaROTH \
                $(TARGET_DIR)/usr/games/ZeldaROTH/
	cp -r $(@D)/src/data $(TARGET_DIR)/usr/games/ZeldaROTH/
endef

$(eval $(generic-package))
