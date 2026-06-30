CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gcab
CLANDRO_PKG_DESCRIPTION="GObject library to create cabinet files"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gcab/${CLANDRO_PKG_VERSION}/gcab-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=2f0c9615577c4126909e251f9de0626c3ee7a152376c15b5544df10fc87e560b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=false
-Dintrospection=true
-Dvapi=true
-Dtests=false
-Dinstalled_tests=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
