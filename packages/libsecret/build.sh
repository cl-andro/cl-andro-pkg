CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libsecret
CLANDRO_PKG_DESCRIPTION="A GObject-based library for accessing the Secret Service API"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@suhan-paradkar"
CLANDRO_PKG_VERSION="0.21.7"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libsecret/${CLANDRO_PKG_VERSION%.*}/libsecret-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6b452e4750590a2b5617adc40026f28d2f4903de15f1250e1d1c40bfd68ed55e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libgcrypt"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtk_doc=false
-Dintrospection=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	# https://gitlab.gnome.org/GNOME/vala/-/issues/1413
	CPPFLAGS+=" -Wno-incompatible-function-pointer-types"
	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libsecret-1.so.0"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		[ -e "${f}" ] || clandro_error_exit "SOVERSION guard check failed."
	done
}
