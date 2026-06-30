CLANDRO_PKG_HOMEPAGE=https://github.com/xapp-project/libadapta
CLANDRO_PKG_DESCRIPTION="libAdapta is libAdwaita with theme support and a few extra"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.0"
CLANDRO_PKG_SRCURL="https://github.com/xapp-project/libadapta/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=725daa7433497b3ae541ba72fe7a075ec1a99693c5598a6c56706f0c3a1f26c9
CLANDRO_PKG_DEPENDS="appstream, sassc, fribidi, glib, graphene, gtk4, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=true
-Dtests=false
-Dexamples=true
-Dc_args=-Wno-error=format-nonliteral
"

clandro_step_post_get_source() {
	rm -f subprojects/*.wrap
}

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libadapta-1.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
