################################################################################
#
# physfs
#
################################################################################
PHYSFS_VERSION = 2.0.3
PHYSFS_SOURCE = physfs-$(PHYSFS_VERSION).tar.bz2
PHYSFS_SITE =  http://icculus.org/physfs/downloads
PHYSFS_LICENCE = GPL
PHYSFS_DEPENDENCIES = 
PHYSFS_INSTALL_STAGING = YES

$(eval $(cmake-package))
