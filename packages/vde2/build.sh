CLANDRO_PKG_HOMEPAGE=https://github.com/virtualsquare/vde-2
CLANDRO_PKG_DESCRIPTION="Virtual Distributed Ethernet for emulators like qemu"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.3
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/virtualsquare/vde-2/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a7d2cc4c3d0c0ffe6aff7eb0029212f2b098313029126dcd12dc542723972379
CLANDRO_PKG_DEPENDS="libpcap, libwolfssl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	autoreconf --install
	CFLAGS+=" -Dindex=strchr -Drindex=strrchr"
}
