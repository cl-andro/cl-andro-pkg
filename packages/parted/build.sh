CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/parted/
CLANDRO_PKG_DESCRIPTION="Versatile partition editor"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.6
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/parted/parted-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=3b43dbe33cca0f9a18601ebab56b7852b128ec1a3df3a9b30ccde5e73359e612
CLANDRO_PKG_DEPENDS="libblkid, libiconv, libuuid, ncurses, readline"
CLANDRO_PKG_BREAKS="parted-dev"
CLANDRO_PKG_REPLACES="parted-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-device-mapper
"

clandro_step_pre_configure() {
	CFLAGS+=" -Wno-gnu-designator"
	export LIBS="-liconv"
}
