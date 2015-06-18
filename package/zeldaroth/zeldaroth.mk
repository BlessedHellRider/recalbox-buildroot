################################################################################
#
# Zelda Roth
#
################################################################################
ZELDAROTH_VERSION = linux
ZELDAROTH_SOURCE = ZeldaROTH-src-$(ZELDAROTH_VERSION).tar.gz
ZELDAROTH_SITE = http://www.zeldaroth.fr/fichier/ROTH/pandora
ZELDAROTH_LICENCE = GPL
ZELDAROTH_DEPENDENCIES = sdl

ZELDAROTH_CFLAGS = -I$(STAGING_DIR)/usr/include -L$(STAGING_DIR)/usr/lib
ZELDAROTH_LDLIBS = -lSDL_gfx -lSDL_image -lSDL_mixer -lSDL

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
        CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" \
        $(MAKE)  CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" CROSS_COMPILE="$(STAGING_DIR)/usr/bin/" \
	PREFIX="$(STAGING_DIR)/usr" \
	PKG_CONFIG="$(HOST_DIR)/usr/bin/pkg-config" \
	HOST_CPU="$(ZELDAROTH_HOST_CPU)" \
	-C $(@D)/projects/unix all $(ZELDAROTH_PARAMS) OPTFLAGS="$(TARGET_CXXFLAGS)" 
endef

define ZELDAROTH_INSTALL_TARGET_CMDS
        mkdir -p $(TARGET_DIR)/usr/games/ZeldaROTH
        $(INSTALL) -D $(@D)/*.* \
                $(TARGET_DIR)/usr/games/ZeldaROTH
endef

define ZELDAROTH_RPI_FIXUP
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/projects/unix/Makefile
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/projects/unix/Makefile
endef

ZELDAROTH_PRE_CONFIGURE_HOOKS += ZELDAROTH_RPI_FIXUP

$(eval $(generic-package))
