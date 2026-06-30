CLANDRO_PKG_HOMEPAGE=https://liblo.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A lightweight library that provides an easy to use implementation of the OSC protocol"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.35"
# https://downloads.sourceforge.net/liblo/liblo-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SRCURL=https://github.com/radarsat1/liblo/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d3d807faa89fc42a5f2468246d212decfa7d2775da879d6aaaa97768aaf8e183
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-doc
"

clandro_step_pre_configure() {
	autoreconf -fiv
}
