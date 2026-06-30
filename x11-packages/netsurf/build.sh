CLANDRO_PKG_HOMEPAGE=https://www.netsurf-browser.org/
CLANDRO_PKG_DESCRIPTION="NetSurf is a free, open source web browser"
CLANDRO_PKG_LICENSE="MIT, GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="netsurf/COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.11"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.netsurf-browser.org/netsurf/releases/source-full/netsurf-all-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4dea880ff3c2f698bfd62c982b259340f9abcd7f67e6c8eb2b32c61f71644b7b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libcurl, libexpat, libiconv, libjpeg-turbo, libpng, librsvg, libwebp, openssl, pango, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export TARGET=gtk3
}

clandro_step_configure () {
	echo CC=$CC
	export HOST=`$CC -dumpmachine`
	export BUILD=`$CC_FOR_BUILD -dumpmachine`
	export CFLAGS+=" -I${CLANDRO_PREFIX}/include"
	export CPPFLAGS+=" -I${CLANDRO_PREFIX}/include"
	export CXXFLAGS+=" -I${CLANDRO_PREFIX}/include"
	mkdir -p netsurf/build/Linux-gtk3
	# Note: NETSURF_USE_DUKTAPE= disables javascript, because I couldn't figure out how to build
	# required the nsgenbind tool so that it can be executed on the *host* (it is used during the build process only)
	make PREFIX="${CLANDRO_PREFIX}" NETSURF_GTK_MAJOR=3 NETSURF_USE_DUKTAPE=NO NETSURF_USE_LIBICONV_PLUG=NO toolchain=clang
}

clandro_step_make() {
	# Nothing to do
	echo CC=$CC
}

clandro_step_make_install () {
	echo CC=$CC
	export HOST=`$CC -dumpmachine`
	export BUILD=`$CC_FOR_BUILD -dumpmachine`
	export CFLAGS+=" -I${CLANDRO_PREFIX}/include"
	export CPPFLAGS+=" -I${CLANDRO_PREFIX}/include"
	export CXXFLAGS+=" -I${CLANDRO_PREFIX}/include"
	make install PREFIX="${CLANDRO_PREFIX}" NETSURF_GTK_MAJOR=3 NETSURF_USE_DUKTAPE=NO NETSURF_USE_LIBICONV_PLUG=NO toolchain=clang
	ln -sfr $CLANDRO_PREFIX/bin/netsurf-gtk3 $CLANDRO_PREFIX/bin/netsurf
}
