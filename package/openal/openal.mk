################################################################################
#
# openal
#
################################################################################
OPENAL_VERSION = 1.15.1
OPENAL_SOURCE = openal-soft-$(OPENAL_VERSION).tar.gz
OPENAL_SITE = https://github.com/JogAmp/openal-soft/archive
OPENAL_LICENCE = GPL
OPENAL_DEPENDENCIES = 
OPENAL_INSTALL_STAGING = YES

$(eval $(cmake-package))
