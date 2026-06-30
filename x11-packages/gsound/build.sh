CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gsound
CLANDRO_PKG_DESCRIPTION="Small gobject library for playing system sounds"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/gsound/${CLANDRO_PKG_VERSION%.*}/gsound-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=ca2d039e1ebd148647017a7f548862350bc9af01986d39f10cfdc8e95f07881a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libcanberra, gobject-introspection"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
-Denable_vala=true
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_gir
}
