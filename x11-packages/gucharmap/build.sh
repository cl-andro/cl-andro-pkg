CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/Gucharmap
CLANDRO_PKG_DESCRIPTION="GTK+ Unicode Character Map"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="17.0.1"
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/gucharmap/-/archive/${CLANDRO_PKG_VERSION}/gucharmap-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=97a642e21d06b295066585e91e6724d622e2b2e952a725e417f81cb0fde9c2ac
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, glib, gtk3, libcairo, pango, pcre2, unicode-data"
CLANDRO_PKG_BUILD_DEPENDS="freetype, g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ducd_path=$CLANDRO_PREFIX/share/unicode-data
-Ddocs=false
-Dgir=true
-Dvapi=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
