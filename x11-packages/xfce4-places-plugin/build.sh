CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-places-plugin/start
CLANDRO_PKG_DESCRIPTION="This plugin brings much of the functionality of GNOME Places menu to Xfce"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION="1.9.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-places-plugin/${CLANDRO_PKG_VERSION%.*}/xfce4-places-plugin-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=76d95687e0bea267465e832eea6266563a18d2219192f9e8af6f88e899262e43
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="exo, gdk-pixbuf, glib, gtk3, libcairo, libnotify, libxfce4ui, libxfce4util, xfce4-panel, xfconf"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibnotify=enabled
"
