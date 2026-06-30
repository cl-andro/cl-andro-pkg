CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/World/gedit/libgedit-tepl
CLANDRO_PKG_DESCRIPTION="Library that eases the development of GtkSourceView-based text editors and IDEs"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.14.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/World/gedit/libgedit-tepl/-/archive/$CLANDRO_PKG_VERSION/libgedit-tepl-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=9ddd8653a673a80a4184efa822578e3f8abdd00a85ec40e3851dee56ff47450c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_DEPENDS="glib, gsettings-desktop-schemas, gtk3, libcairo, libgedit-amtk, libgedit-gfls, libgedit-gtksourceview, libhandy, libicu, pango"
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
	local _GUARD_FILE="lib/libgedit-tepl-6.so.4"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
