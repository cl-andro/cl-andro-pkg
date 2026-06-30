CLANDRO_PKG_HOMEPAGE=https://download.gnome.org/sources/murrine/
CLANDRO_PKG_DESCRIPTION="Gtk +-2.0 theme engine based on cairo"
CLANDRO_PKG_LICENSE="LGPL-2.1, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION=0.98.2
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=http://deb.debian.org/debian/pool/main/g/gtk2-engines-murrine/gtk2-engines-murrine_${CLANDRO_PKG_VERSION}.orig.tar.xz
CLANDRO_PKG_SHA256=e9c68ae001b9130d0f9d1b311e8121a94e5c134b82553ba03971088e57d12c89
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk2, libcairo, libpixman, pango"

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
}

clandro_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
