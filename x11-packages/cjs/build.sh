CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/cjs
CLANDRO_PKG_DESCRIPTION="JavaScript Bindings for Cinnamon"
CLANDRO_PKG_LICENSE="MIT, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="128.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/cjs/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=20e59f7402f960fbba184b2eb2cdee60e316554fd771bf4d5598ec5e3b9d1002
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
CLANDRO_PKG_DEPENDS="glib, gobject-introspection, libcairo, libffi, libx11, readline, spidermonkey"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Db_pch=false
-Dinstalled_tests=false
-Dskip_dbus_tests=true
-Dskip_gtk_tests=true
-Dskip_tests=true
"

clandro_step_post_get_source() {
	# Do not use meson wrap projects
	rm -f subprojects/*.wrap
}

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
