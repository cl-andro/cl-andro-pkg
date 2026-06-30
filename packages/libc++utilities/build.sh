CLANDRO_PKG_HOMEPAGE=https://github.com/Martchus/cpp-utilities
CLANDRO_PKG_DESCRIPTION="Useful C++ classes and routines such as argument parser, IO and conversion utilities"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.34.0"
CLANDRO_PKG_SRCURL=https://github.com/Martchus/cpp-utilities/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7cb228606e79b9a33244cea062674d6339b0db00081f6cae9b3b7d12619fa7db
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="boost, libc++, libiconv"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
