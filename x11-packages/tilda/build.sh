CLANDRO_PKG_HOMEPAGE=https://github.com/lanoxx/tilda
CLANDRO_PKG_DESCRIPTION="A Gtk based drop down terminal for Linux and Unix."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/lanoxx/tilda/archive/refs/tags/tilda-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ff9364244c58507cd4073ac22e580a4cded048d416c682496c1b1788ee8a30df
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libconfuse, libvte, libx11, pango"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}
