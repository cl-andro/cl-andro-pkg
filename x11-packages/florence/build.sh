CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/florence/
CLANDRO_PKG_DESCRIPTION="A configurable on-screen virtual keyboard"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.6.3
CLANDRO_PKG_REVISION=35
CLANDRO_PKG_SRCURL=https://sourceforge.net/projects/florence/files/florence/${CLANDRO_PKG_VERSION}/florence-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=422992fd07d285be73cce721a203e22cee21320d69b0fda1579ce62944c5091e
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gstreamer, gtk3, libcairo, librsvg, libx11, libxext, libxml2, libxtst, pango"
CLANDRO_PKG_MAKE_PROCESSES=1

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--without-notification
--without-at-spi
--with-panelapplet
--with-xtst
--without-docs
"

CLANDRO_PKG_RM_AFTER_INSTALL="
lib/locale
"

clandro_step_pre_configure() {
	export LIBS="-lglib-2.0 -lgio-2.0"
}
