CLANDRO_PKG_HOMEPAGE=https://www.gtk.org/docs/architecture/pango
CLANDRO_PKG_DESCRIPTION="Library for laying out and rendering text"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.57.1"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/pango/${CLANDRO_PKG_VERSION%.*}/pango-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=e65d6d117080dc3aeeb7d8b4b3b518f7383aa2e6cfce23117c623cd624764c2f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, fribidi, glib, harfbuzz, libcairo, libx11, libxft, libxrender"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_BREAKS="pango-dev"
CLANDRO_PKG_REPLACES="pango-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-testsuite=false
-Dintrospection=enabled
-Dman-pages=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES=(
		'lib/libpango-1.0.so.0'
		'lib/libpangocairo-1.0.so.0'
		'lib/libpangoft2-1.0.so.0'
		'lib/libpangoxft-1.0.so.0'
	)

	local f
	for f in "${_SOVERSION_GUARD_FILES[@]}"; do
		[ -e "${f}" ] || clandro_error_exit "SOVERSION guard check failed."
	done
}
