CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/vte/
CLANDRO_PKG_DESCRIPTION="Virtual Terminal library"
CLANDRO_PKG_LICENSE="LGPL-3.0, GPL-3.0, MIT"
CLANDRO_PKG_LICENSE_FILE="COPYING.GPL3, COPYING.LGPL3, COPYING.XTERM"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2:0.84.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/vte/-/archive/${CLANDRO_PKG_VERSION:2}/vte-${CLANDRO_PKG_VERSION:2}.tar.bz2
#CLANDRO_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/vte/${_MAJOR_VERSION}/vte-${_VERSION}.tar.xz
CLANDRO_PKG_SHA256=b215d2c8e56fa03e04dfd1b6c5576479484be15227fa49c236271b46d08581d0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, fribidi, gdk-pixbuf, glib, gtk3, gtk4, libc++, libcairo, libgnutls, libicu, liblz4, libsimdutf, pango, pcre2, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/locale"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgir=true
-Dvapi=true
-D_systemd=false
"

clandro_step_post_get_source() {
	rm -f subprojects/simdutf.wrap
}

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	CPPFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX -Wno-cast-function-type-strict -Wno-deprecated-declarations -Wno-cast-function-type"
	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES=(
		'lib/libvte-2.91-gtk4.so.0'
		'lib/libvte-2.91.so.0'
	)

	local f
	for f in "${_SOVERSION_GUARD_FILES[@]}"; do
		[ -e "${f}" ] || clandro_error_exit "SOVERSION guard check failed."
	done
}
