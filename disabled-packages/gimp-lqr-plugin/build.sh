# Origin Repo: x11-packages
CLANDRO_PKG_HOMEPAGE=https://github.com/carlobaldassi/gimp-lqr-plugin
CLANDRO_PKG_DESCRIPTION="LiquidRescale plug-in for seam carving in GIMP"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7.2
CLANDRO_PKG_SRCURL=https://github.com/carlobaldassi/gimp-lqr-plugin/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a01ffdfc04e97167413b4bb11516d3bad28dadb84bbfacb5e6ed21959483ebe1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="gdk-pixbuf, gimp, glib, gtk2, liblqr"

clandro_step_pre_configure() {
	CFLAGS+=" -fcommon"
}
