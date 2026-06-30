CLANDRO_PKG_HOMEPAGE=https://dasm-dillon.sourceforge.io/
CLANDRO_PKG_DESCRIPTION="Macro assembler with support for several 8-bit microprocessors"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.20.14.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/dasm-assembler/dasm/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ec71ffd10eeaa70bf7587ee0d79a92cd3f0a017c0d6d793e37d10359ceea663a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	cp $CLANDRO_PKG_SRCDIR/bin/* $CLANDRO_PREFIX/bin/
}
