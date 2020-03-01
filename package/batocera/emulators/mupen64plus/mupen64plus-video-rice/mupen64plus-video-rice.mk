################################################################################
#
# mupen64plus video video-rice
#
################################################################################
# Version.: Commits on Nov 15, 2019
MUPEN64PLUS_VIDEO_RICE_VERSION = 677257a3110abc4a5ce2fa3dd7e58443c2cdc7a0
MUPEN64PLUS_VIDEO_RICE_SITE = $(call github,mupen64plus,mupen64plus-video-rice,$(MUPEN64PLUS_VIDEO_RICE_VERSION))
MUPEN64PLUS_VIDEO_RICE_LICENSE = GPLv2
MUPEN64PLUS_VIDEO_RICE_DEPENDENCIES = sdl2 alsa-lib mupen64plus-core boost
MUPEN64PLUS_VIDEO_RICE_INSTALL_STAGING = YES

define MUPEN64PLUS_VIDEO_RICE_BUILD_CMDS
    CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" \
        $(MAKE)  CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" CROSS_COMPILE="$(STAGING_DIR)/usr/bin/" \
		PREFIX="$(STAGING_DIR)/usr" \
		PKG_CONFIG="$(HOST_DIR)/usr/bin/pkg-config" \
		HOST_CPU="$(MUPEN64PLUS_HOST_CPU)" \
        APIDIR="$(STAGING_DIR)/usr/include/mupen64plus" \
		GL_CFLAGS="$(MUPEN64PLUS_GL_CFLAGS)" \
		GL_LDLIBS="$(MUPEN64PLUS_GL_LDLIBS)" \
        NO_SSE=1 \
		-C $(@D)/projects/unix all $(MUPEN64PLUS_PARAMS) OPTFLAGS="$(TARGET_CXXFLAGS)"
endef

define MUPEN64PLUS_VIDEO_RICE_INSTALL_TARGET_CMDS
    CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" \
        $(MAKE)  CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" CROSS_COMPILE="$(STAGING_DIR)/usr/bin/" \
		PREFIX="$(TARGET_DIR)/usr/" \
		PKG_CONFIG="$(HOST_DIR)/usr/bin/pkg-config" \
		HOST_CPU="$(MUPEN64PLUS_HOST_CPU)" \
        APIDIR="$(STAGING_DIR)/usr/include/mupen64plus" \
		GL_CFLAGS="$(MUPEN64PLUS_GL_CFLAGS)" \
		GL_LDLIBS="$(MUPEN64PLUS_GL_LDLIBS)" \
		INSTALL="/usr/bin/install" \
		INSTALL_STRIP_FLAG="" \
		-C $(@D)/projects/unix all $(MUPEN64PLUS_PARAMS) OPTFLAGS="$(TARGET_CXXFLAGS)" install
endef

define MUPEN64PLUS_VIDEO_RICE_CROSS_FIXUP
    $(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/projects/unix/Makefile
    $(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/projects/unix/Makefile
endef

MUPEN64PLUS_VIDEO_RICE_PRE_CONFIGURE_HOOKS += MUPEN64PLUS_VIDEO_RICE_CROSS_FIXUP

$(eval $(generic-package))