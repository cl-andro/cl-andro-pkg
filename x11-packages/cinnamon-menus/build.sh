CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/cinnamon-menus
CLANDRO_PKG_DESCRIPTION="The cinnamon-menu library "
CLANDRO_PKG_LICENSE="MIT, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/cinnamon-menus/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=87596380720077991f58afdbbabe72d9afd10f56d64043076cf7b09bc6b0f3c1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_DEPENDS="glib, gobject-introspection"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable_debug=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_meson

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
