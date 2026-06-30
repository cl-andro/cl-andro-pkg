CLANDRO_PKG_HOMEPAGE=https://github.com/wmww/gtk-layer-shell
CLANDRO_PKG_DESCRIPTION="Library to create panels and other desktop components for Wayland using the Layer Shell protocol"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.1"
CLANDRO_PKG_SRCURL=git+https://github.com/wmww/gtk-layer-shell
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk3, libwayland"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, libwayland-cross-scanner, libwayland-protocols"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=false
-Dintrospection=true
-Dtests=false
-Dvapi=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_wayland_cross_pkg_config_wrapper
}
