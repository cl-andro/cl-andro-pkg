CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/chergert/libspelling/
CLANDRO_PKG_DESCRIPTION="Spellcheck library for GTK 4"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.10"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libspelling/${CLANDRO_PKG_VERSION%.*}/libspelling-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=56e3f01a3a18b575beea4c34349f99cdaba316e1f7c271b1231f7bcf5d9af73b
CLANDRO_PKG_DEPENDS="enchant, glib, gtk4, gtksourceview5, libicu, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=false
-Denchant=enabled
-Dintrospection=enabled
-Dsysprof=false
-Dvapi=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
