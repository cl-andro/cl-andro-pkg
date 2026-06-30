CLANDRO_PKG_HOMEPAGE=https://github.com/any1/neatvnc
CLANDRO_PKG_DESCRIPTION="A liberally licensed VNC server library with a clean interface"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.0"
CLANDRO_PKG_SRCURL=https://github.com/any1/neatvnc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=993dedc30e72981650770c04438e9759537e4677010e2dab5e792c39afe74601
CLANDRO_PKG_DEPENDS="libaml, libdrm, libgmp, libgnutls, libjpeg-turbo, libnettle, libpixman, zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Djpeg=enabled
-Dtls=enabled
-Dnettle=enabled
-Dgbm=disabled
"
