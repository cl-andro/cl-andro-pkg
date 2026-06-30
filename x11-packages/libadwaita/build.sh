CLANDRO_PKG_HOMEPAGE=https://gnome.pages.gitlab.gnome.org/libadwaita/
CLANDRO_PKG_DESCRIPTION="Building blocks for modern adaptive GNOME applications"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9.0"
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/libadwaita/-/archive/${CLANDRO_PKG_VERSION}/libadwaita-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=484c1665647c17fc57729120f51a76f76e73b6ac1fd1c29c9690c7f6b4d62399
CLANDRO_PKG_DEPENDS="appstream, fribidi, glib, graphene, gtk4, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-regex
# libadwaita sometimes releases tags for older versions with newer tag dates.
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=true
-Dtests=false
-Dexamples=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libadwaita-1.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
