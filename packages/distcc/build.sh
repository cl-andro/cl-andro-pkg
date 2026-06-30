CLANDRO_PKG_HOMEPAGE=http://distcc.org/
CLANDRO_PKG_DESCRIPTION="Distributed C/C++ compiler"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.4
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/distcc/distcc/releases/download/v$CLANDRO_PKG_VERSION/distcc-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=2b99edda9dad9dbf283933a02eace6de7423fe5650daa4a728c950e5cd37bd7d
CLANDRO_PKG_DEPENDS="libpopt"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pump-mode
--without-avahi
--without-gtk
--without-libiberty"

clandro_step_pre_configure() {
	./autogen.sh
	CFLAGS+=" -Wno-error=strict-prototypes"
	export LIBS="-llog"
}
