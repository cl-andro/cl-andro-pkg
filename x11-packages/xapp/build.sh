CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/xapp
CLANDRO_PKG_DESCRIPTION="Cross-desktop libraries and common resources "
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.2.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/xapp/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=d0ea664053e6f35cc556e060b161905004f03d0695473772d2fb8a37cf445591
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="glib, dbus, gigolo, gtk3, gdk-pixbuf, libcairo, libx11, libgnomekbd, pygobject, gobject-introspection, libdbusmenu, libdbusmenu-gtk3, xapp-symbolic-icons"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=false
-Dpy-overrides-dir=$CLANDRO_PYTHON_HOME/site-packages/gi/overrides
-Dintrospection=true
-Dvapi=true
-Dxfce=false
-Dmate=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
