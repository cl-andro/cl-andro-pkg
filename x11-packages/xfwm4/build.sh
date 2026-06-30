CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/xfwm4/start
CLANDRO_PKG_DESCRIPTION="Window manager for XFCE environment"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfwm4/${CLANDRO_PKG_VERSION%.*}/xfwm4-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=a58b63e49397aa0d8d1dcf0636be93c8bb5926779aef5165e0852890190dcf06
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libepoxy, libwnck, libx11, libxcomposite, libxdamage, libxext, libxfce4ui, libxfce4util, libxfixes, libxinerama, libxpresent, libxrandr, libxrender, pango, startup-notification, xfconf"
CLANDRO_PKG_BUILD_DEPENDS="xfce4-dev-tools"
CLANDRO_PKG_RECOMMENDS="hicolor-icon-theme"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--enable-startup-notification
--enable-randr
--enable-compositor
--enable-xsync
"
