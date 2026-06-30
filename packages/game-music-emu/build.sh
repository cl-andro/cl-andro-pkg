CLANDRO_PKG_HOMEPAGE=https://bitbucket.org/mpyne/game-music-emu/wiki/Home
CLANDRO_PKG_DESCRIPTION="A collection of video game music file emulators"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.5"
CLANDRO_PKG_SRCURL=https://github.com/libgme/game-music-emu/releases/download/${CLANDRO_PKG_VERSION}/libgme-${CLANDRO_PKG_VERSION}-src.tar.gz
CLANDRO_PKG_SHA256=a133f19278222136ba0d8c27b64a07987ba05fec9d2e6d293ccd8cabdd97ddbb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DGME_YM2612_EMU=Nuked
-DENABLE_UBSAN=OFF
"
