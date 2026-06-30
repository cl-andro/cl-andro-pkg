CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/xfce4-appfinder/start
CLANDRO_PKG_DESCRIPTION="Application launcher and finder"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfce4-appfinder/${CLANDRO_PKG_VERSION%.*}/xfce4-appfinder-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=82ca82f77dc83e285db45438c2fe31df445148aa986ffebf2faabee4af9e7304
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="garcon, gdk-pixbuf, glib, gtk3, libcairo, libxfce4ui, libxfce4util, xfconf"
CLANDRO_PKG_BUILD_DEPENDS="xfce4-dev-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
"
