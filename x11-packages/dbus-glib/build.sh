CLANDRO_PKG_HOMEPAGE=https://dbus.freedesktop.org
CLANDRO_PKG_DESCRIPTION="GLib bindings for DBUS"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.114"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=c09c5c085b2a0e391b8ee7d783a1d63fe444e96717cc1814d61b5e8fc2827a7c
CLANDRO_PKG_DEPENDS="dbus, glib, libexpat"
CLANDRO_PKG_BREAKS="dbus-glib-dev"
CLANDRO_PKG_REPLACES="dbus-glib-dev"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	(cd $CLANDRO_PKG_SRCDIR && autoconf -i)
	$CLANDRO_PKG_SRCDIR/configure
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_pre_configure() {
	export GLIB_GENMARSHAL=glib-genmarshal
	autoconf -i
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --with-dbus-binding-tool=$CLANDRO_PKG_HOSTBUILD_DIR/dbus/dbus-binding-tool"
}
