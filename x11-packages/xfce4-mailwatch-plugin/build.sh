CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-mailwatch-plugin/start
CLANDRO_PKG_DESCRIPTION="Xfce4 Mailwatch Plugin is a multi-protocol, multi-mailbox mail watcher for the Xfce4 panel."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-mailwatch-plugin/${CLANDRO_PKG_VERSION%.*}/xfce4-mailwatch-plugin-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=5c211025db1096663fa6b8cc41213464a6d71f24e76326499d857ff81ea3861f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="exo, gdk-pixbuf, glib, gtk3, libcairo, libgnutls, libxfce4ui, libxfce4util, xfce4-panel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgnutls=enabled
-Dipv6=enabled
"
