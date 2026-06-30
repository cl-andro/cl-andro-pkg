CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/World/gedit/libgedit-amtk
CLANDRO_PKG_DESCRIPTION="Actions, Menus and Toolbars Kit for GTK applications"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.10.0"
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/World/gedit/libgedit-amtk/-/archive/${CLANDRO_PKG_VERSION}/libgedit-amtk-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6c884bf4c9716110930c17f0103d01e1fa2fa5c5b705803b0d4ddf72ba6094f4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk3"
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
	local _GUARD_FILE="lib/libgedit-amtk-5.so.0"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
