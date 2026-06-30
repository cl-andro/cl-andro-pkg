CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-pulseaudio-plugin/start
CLANDRO_PKG_DESCRIPTION="Pulseaudio plugin for the Xfce4 panel"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-pulseaudio-plugin/${CLANDRO_PKG_VERSION%.*}/xfce4-pulseaudio-plugin-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=8e1f3a505f37aa3bc2816a58bec5f9555366f1c476f10eab59fd0e6581d08c47
CLANDRO_PKG_DEPENDS="exo, gdk-pixbuf, glib, gtk3, libcairo, libcanberra, libnotify, libxfce4ui, libxfce4util, libxfce4windowing, pavucontrol, pulseaudio, xfce4-panel, xfconf"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
