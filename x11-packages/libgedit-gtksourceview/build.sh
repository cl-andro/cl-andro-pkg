CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/World/gedit/libgedit-gtksourceview
CLANDRO_PKG_DESCRIPTION="A source code editing widget"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="299.7.0"
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/World/gedit/libgedit-gtksourceview/-/archive/${CLANDRO_PKG_VERSION}/libgedit-gtksourceview-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c08a70666d5aad156a3fe9dd178ddd3bdf07b3733a1d37dccae0e366585e91f0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libgedit-amtk, libgedit-gfls, libxml2, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgobject_introspection=true
-Dgtk_doc=false
-Dtests=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _GUARD_FILE="lib/libgedit-gtksourceview-300.so.5"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
