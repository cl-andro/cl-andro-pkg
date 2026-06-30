CLANDRO_PKG_HOMEPAGE=https://github.com/sunnyone/loqui
CLANDRO_PKG_DESCRIPTION="IRC client for Gtk environment"
CLANDRO_PKG_LICENSE="LGPL-2.0, GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/sunnyone/loqui/releases/download/${CLANDRO_PKG_VERSION}/loqui-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c593211d6bb477d5477ec9b81143e3faf96e859ad2edaf527fbc370333e5e0e7
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, pango"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
GLIB_GENMARSHAL=glib-genmarshal
--disable-glibtestr
--disable-gtktest
"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/locale"

clandro_step_pre_configure() {
	CFLAGS+=" -Wno-error=return-type"
}
