CLANDRO_PKG_HOMEPAGE=https://github.com/andmarti1424/sc-im
CLANDRO_PKG_DESCRIPTION="An improved version of sc, a spreadsheet calculator"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.5"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/andmarti1424/sc-im/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=49adb76fc55bc3e6ea8ee414f41428db4aef947e247718d9210be8d14a6524bd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libandroid-wordexp, lua54, libxls, libxlsxwriter, libxml2, libzip, ncurses"
CLANDRO_PKG_SUGGESTS="gnuplot"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
LUA_PKGNAME=lua54
"

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS -I$CLANDRO_PREFIX/include/libandroid-support -DGNUPLOT"
	LDFLAGS+=" -landroid-wordexp"
	CLANDRO_PKG_BUILDDIR+="/src"
}
