CLANDRO_PKG_HOMEPAGE=https://git.kernel.org/cgit/devel/pahole/pahole.git/
CLANDRO_PKG_DESCRIPTION="Pahole and other DWARF utils"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.31"
CLANDRO_PKG_SRCURL=https://fedorapeople.org/~acme/dwarves/dwarves-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=0a7f255ccacf8cc7f8cd119099eb327179b4b3c67cb015af646af6d0cb03054d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="argp, libdw, libelf, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-D__LIB=lib"

clandro_step_pre_configure() {
	cp "$CLANDRO_PKG_BUILDER_DIR"/obstack.h "$CLANDRO_PKG_SRCDIR"/
}
