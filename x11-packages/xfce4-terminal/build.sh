CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/apps/terminal/start
CLANDRO_PKG_DESCRIPTION="Terminal Emulator for the XFCE environment"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.0"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-terminal/${CLANDRO_PKG_VERSION%.*}/xfce4-terminal-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6874c7b975cc3dc3bd636d57ffec723de7458202defe65377593d3a7e0734b94
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, gtk-layer-shell, libcairo, libvte, libx11, libxfce4ui, libxfce4util, pango, pcre2, xfconf"
CLANDRO_PKG_RECOMMENDS="desktop-file-utils, hicolor-icon-theme"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtk-layer-shell=enabled
-Dwayland=enabled
-Dx11=enabled
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
