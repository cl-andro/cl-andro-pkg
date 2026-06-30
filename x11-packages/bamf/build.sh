CLANDRO_PKG_HOMEPAGE=https://launchpad.net/bamf
CLANDRO_PKG_DESCRIPTION="Application matching framework"
CLANDRO_PKG_LICENSE="GPL-3.0, LGPL-2.1, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://launchpad.net/bamf/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/+download/bamf-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=4fcd00f23c542f3b79f35e10e322b67eacb399cac83f48db261cd8e8ea709478
CLANDRO_PKG_DEPENDS="bash, gdk-pixbuf, glib, gtk3, libgtop, libwnck, libx11, startup-notification"
CLANDRO_PKG_BUILD_DEPENDS="glib, gnome-common, gobject-introspection, valac, python-lxml, autoconf, automake, libtool, gtk-doc"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--libexecdir=$CLANDRO_PREFIX/lib
--disable-gtk-doc
--with-systemduserunitdir=no
"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_gir
	autoreconf -fi
}
