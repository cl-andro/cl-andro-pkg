CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/World/gedit/libgedit-gfls
CLANDRO_PKG_DESCRIPTION="A module dedicated to file loading and saving"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.1"
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/World/gedit/libgedit-gfls/-/archive/${CLANDRO_PKG_VERSION}/libgedit-gfls-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3fea829f8a037da167898ad53533960173f1e9af5285b97c4201b69d973e1a6f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_DEPENDS="glib"
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
	local _GUARD_FILE="lib/libgedit-gfls-1.so.0"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
