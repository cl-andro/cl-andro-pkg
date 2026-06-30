CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Libpeas
CLANDRO_PKG_DESCRIPTION="A gobject-based plugins engine"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.38.1"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libpeas/${CLANDRO_PKG_VERSION%.*}/libpeas-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=e82fd328adcac1aba34b64136bdfcbbacf2b3258a8bc4e5f480a72502a611ae9
CLANDRO_PKG_DEPENDS="glib, gobject-introspection, gtk3"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dlua51=false
-Dpython3=false
-Dintrospection=true
-Ddemos=false
-Dgtk_doc=false
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
		'lib/libpeas-1.0.so.1'
		'lib/libpeas-gtk-1.0.so.1'
	)

	local f
	for f in "${_SOVERSION_GUARD_FILES[@]}"; do
		[ -e "${f}" ] || clandro_error_exit "SOVERSION guard check failed."
	done
}
