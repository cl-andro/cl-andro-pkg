CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-netload-plugin/start
CLANDRO_PKG_DESCRIPTION="network load monitor plugin for the Xfce4 panel"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION="1.5.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-netload-plugin/${CLANDRO_PKG_VERSION%.*}/xfce4-netload-plugin-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=a868be8f73e8396c2d61903d46646993c5130d16ded71ddb5da9088abf7cb7ba
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk3, libxfce4ui, libxfce4util, xfce4-panel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
"
