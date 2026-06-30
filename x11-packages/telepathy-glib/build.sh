CLANDRO_PKG_HOMEPAGE=https://telepathy.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="GLib bindings for the Telepathy D-Bus protocol"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
# Do not bump to 0.99.x.
CLANDRO_PKG_VERSION=1:0.24.2
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://telepathy.freedesktop.org/releases/telepathy-glib/telepathy-glib-${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=b0a374d771cdd081125f38c3abd079657642301c71a543d555e2bf21919273f0
CLANDRO_PKG_DEPENDS="dbus-glib, glib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_BREAKS="telepathy-glib-dev"
CLANDRO_PKG_REPLACES="telepathy-glib-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}

clandro_step_post_massage() {
	local _GUARD_FILES="lib/libtelepathy-glib.so"
	local f
	for f in ${_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "file ${f} not found."
		fi
	done
}
