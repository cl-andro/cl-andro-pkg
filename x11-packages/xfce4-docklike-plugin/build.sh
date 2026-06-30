CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-docklike-plugin/start
CLANDRO_PKG_DESCRIPTION="A modern, docklike, minimalist taskbar for XFCE"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.1"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-docklike-plugin/${CLANDRO_PKG_VERSION%.*}/xfce4-docklike-plugin-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=9d7b355c2be37fb0a73b77b4ed75f092d23c012a67b102c9f847c55ddc3095df
# exo is for bin/exo-desktop-item-edit.
CLANDRO_PKG_DEPENDS="exo, gdk-pixbuf, glib, gtk3, gtk-layer-shell, libc++, libcairo, libx11, libxi, libxfce4ui, libxfce4util, libxfce4windowing, xfce4-panel"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dwayland=enabled
-Dx11=enabled
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
