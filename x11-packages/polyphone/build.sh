CLANDRO_PKG_HOMEPAGE=https://www.polyphone-soundfonts.com/
CLANDRO_PKG_DESCRIPTION="An open-source soundfont editor for creating musical instruments"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/davy7125/polyphone/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ecf401f2a083bb5396032953bb3d051e39aa4483063da9546852219ad532605a
CLANDRO_PKG_DEPENDS="glib, libc++, libflac, libogg, librtmidi, libvorbis, openssl, portaudio, qcustomplot, qt5-qtbase, qt5-qtsvg, zlib"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
DEFINES+=USE_LOCAL_STK
PKG_CONFIG=pkg-config
PREFIX=$CLANDRO_PREFIX
"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/sources"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"
}

clandro_step_configure() {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross" \
		${CLANDRO_PKG_EXTRA_CONFIGURE_ARGS}
}
