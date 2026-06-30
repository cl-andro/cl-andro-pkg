CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/nemo
CLANDRO_PKG_DESCRIPTION="Cinnamon File manager"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/nemo/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=258807feb2e7bac523707d6b3daf2d9439e7135123cbe795183d5aaa6fd691ed
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_DEPENDS="glib, gtk3, gobject-introspection, pygobject, json-glib, cinnamon-desktop, libx11, xapp, libexif, pango, libgsf, dbus-python, libcairo, gvfs, libheif-progs, tinysparql"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dxmp=false
-Dgtk_doc=false
-Dselinux=false
-Dtracker=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
