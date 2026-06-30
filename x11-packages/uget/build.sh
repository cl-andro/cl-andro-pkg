CLANDRO_PKG_HOMEPAGE=https://ugetdm.com/
CLANDRO_PKG_DESCRIPTION="GTK+ download manager featuring download classification and HTML import"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.2.3
CLANDRO_PKG_REVISION=23
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/urlget/uget-${CLANDRO_PKG_VERSION}-1.tar.gz
CLANDRO_PKG_SHA256=11356e4242151b9014fa6209c1f0360b699b72ef8ab47dbeb81cc23be7db9049
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gstreamer, gtk3, libcairo, libcurl, libnotify, openssl, pango"
CLANDRO_PKG_SUGGESTS="aria2"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/locale"

clandro_step_pre_configure() {
	CFLAGS+=" -fcommon"
}

clandro_step_post_make_install() {
	ln -sfr "${CLANDRO_PREFIX}/bin/uget-gtk" "${CLANDRO_PREFIX}/bin/uget"
}
