CLANDRO_PKG_HOMEPAGE=https://libsoup.gnome.org/libsoup-3.0/
CLANDRO_PKG_DESCRIPTION="HTTP client and server library"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.6.6"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libsoup/${CLANDRO_PKG_VERSION%.*}/libsoup-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=51ed0ae06f9d5a40f401ff459e2e5f652f9a510b7730e1359ee66d14d4872740
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="brotli, glib, libnghttp2, libpsl, libsqlite, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_RECOMMENDS="glib-networking"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=enabled
-Ddocs=disabled
-Dgssapi=disabled
-Dtests=false
-Dtls_check=false
-Dsysprof=disabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libsoup-3.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
