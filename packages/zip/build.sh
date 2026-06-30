CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/infozip/
CLANDRO_PKG_DESCRIPTION="Tools for working with zip files"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0"
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL="https://downloads.sourceforge.net/infozip/zip${CLANDRO_PKG_VERSION/.}.tar.gz"
CLANDRO_PKG_SHA256=f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369
CLANDRO_PKG_DEPENDS="libandroid-support, libbz2"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	cp unix/Makefile Makefile
}

clandro_step_make() {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" make -j $CLANDRO_PKG_MAKE_PROCESSES generic
}
