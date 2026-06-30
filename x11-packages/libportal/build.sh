CLANDRO_PKG_HOMEPAGE=https://libportal.org/
CLANDRO_PKG_DESCRIPTION="Flatpak portal library"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/flatpak/libportal/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ea422b789ae487e04194d387bea031fd7485bf88a18aef8c767f7d1c29496a4e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbackend-gtk3=enabled
-Dbackend-gtk4=enabled
-Dbackend-qt6=enabled
-Dintrospection=true
-Dvapi=true
-Ddocs=false
-Dtests=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
