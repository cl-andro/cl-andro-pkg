CLANDRO_PKG_HOMEPAGE=https://flacon.github.io/
CLANDRO_PKG_DESCRIPTION="Extracts individual tracks from one big audio file and saves them as separate audio files"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="12.0.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/flacon/flacon/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=78199ff925b7cd0ffeb628d47909ca4172f8ff0d8fd8192bb537e0c012e6f4c6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libuchardet, qt6-qtbase, taglib"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DUSE_QT5=OFF -DUSE_QT6=ON"
