CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-clipman-plugin/start
CLANDRO_PKG_DESCRIPTION="Clipman is a clipboard manager for Xfce"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-clipman-plugin/${CLANDRO_PKG_VERSION%.*}/xfce4-clipman-plugin-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=903302c3070a951d44ee17a84fa3cf21d36c6787678af8fbfc79e469fd00cb46
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gdk-pixbuf, gtk3, libcairo, libqrencode, libwayland, libx11, libxfce4ui, libxfce4util, libxtst, xfce4-panel, xfconf"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross, libwayland-protocols, libwayland-cross-scanner"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dqrencode=enabled
-Dtests=false
-Dwayland=enabled
-Dx11=enabled
-Dxtst=enabled
"

clandro_step_pre_configure() {
	clandro_setup_pkg_config_wrapper \
	"${CLANDRO_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig:${CLANDRO_PREFIX}/opt/libwayland/cross/lib/x86_64-linux-gnu/pkgconfig"
}
