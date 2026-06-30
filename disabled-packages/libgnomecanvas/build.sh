CLANDRO_PKG_HOMEPAGE=https://www.gnome.org/
CLANDRO_PKG_DESCRIPTION="The GNOME Canvas library"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.30.3
CLANDRO_PKG_REVISION=21
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libgnomecanvas/2.30/libgnomecanvas-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=859b78e08489fce4d5c15c676fec1cd79782f115f516e8ad8bed6abcb8dedd40
CLANDRO_PKG_DEPENDS="atk, glib, gtk2, libart-lgpl, libglade, pango"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-glade"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/locale"

clandro_step_post_configure() {
	sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
}
