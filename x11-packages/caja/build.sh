CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="The file manager for the MATE desktop"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://pub.mate-desktop.org/releases/${CLANDRO_PKG_VERSION%.*}/caja-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1e3014ce1455817ec2ef74d09efdfb6835d8a372ed9a16efb5919ef7b821957a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libexif, libice, libnotify, libsm, libx11, libxml2, mate-desktop, pango, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-xmp
--disable-packagekit
--disable-schemas-compile
--enable-introspection
--disable-update-mimedb
--disable-icon-update
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
