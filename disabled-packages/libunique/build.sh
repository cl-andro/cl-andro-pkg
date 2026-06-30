CLANDRO_PKG_HOMEPAGE=https://gnome.org
CLANDRO_PKG_DESCRIPTION="Library for writing single instance applications"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.2"
CLANDRO_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/libunique/${CLANDRO_PKG_VERSION%.*}/libunique-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=50269a87c7aabf1e25f01b3bbb280133138ffd7b6776289894c614a4b6ca968d
CLANDRO_PKG_DEPENDS="glib, gtk2"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_MAKE_ARGS="V=1"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-dbus=no
--enable-introspection=yes
"

clandro_step_pre_configure() {
	autoreconf -fi

	clandro_setup_gir

	export CFLAGS="$CFLAGS -DG_CONST_RETURN=const"
	export GLIB_GENMARSHAL=$(command -v glib-genmarshal)
	export GLIB_MKENUMS=$(command -v glib-mkenums)
}

clandro_step_post_configure() {
	touch ./unique/g-ir-{scanner,compiler}
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libunique-3.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
