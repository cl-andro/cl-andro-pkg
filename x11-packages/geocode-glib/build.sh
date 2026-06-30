CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/geocode-glib
CLANDRO_PKG_DESCRIPTION="Convenience library for the geocoding and reverse geocoding"
CLANDRO_PKG_LICENSE="GPL-2.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.26.4"
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/geocode-glib/${CLANDRO_PKG_VERSION%.*}/geocode-glib-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=2d9a6826d158470449a173871221596da0f83ebdcff98b90c7049089056a37aa
CLANDRO_PKG_DEPENDS="glib, json-glib, libsoup3"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-installed-tests=false
-Denable-gtk-doc=false
-Dsoup2=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
