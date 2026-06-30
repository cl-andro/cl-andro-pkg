CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/JsonGlib
CLANDRO_PKG_DESCRIPTION="GLib JSON manipulation library"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.10.8"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/json-glib/${CLANDRO_PKG_VERSION%.*}/json-glib-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=55c5c141a564245b8f8fbe7698663c87a45a7333c2a2c56f06f811ab73b212dd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_BREAKS="json-glib-dev"
CLANDRO_PKG_REPLACES="json-glib-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocumentation=disabled
-Dintrospection=enabled
-Dman=true
-Dtests=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
