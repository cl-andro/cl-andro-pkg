CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gspell
CLANDRO_PKG_DESCRIPTION="Spell-checking for GTK applications"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.14.3"
# https://download.gnome.org/sources/gspell/${CLANDRO_PKG_VERSION%.*}/gspell-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/gspell/-/archive/${CLANDRO_PKG_VERSION}/gspell-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fc873525d6f2a930cadb18d5f14b657731a55ef5bcb76b415bb628f9a5091e4f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="enchant, glib, gtk3, libicu, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgobject_introspection=true
-Dgtk_doc=false
-Dinstall_tests=false
-Dtests=false
-Dvapi=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
