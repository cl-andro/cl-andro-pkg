CLANDRO_PKG_HOMEPAGE=https://libmateweather.mate-desktop.dev/
CLANDRO_PKG_DESCRIPTION="libmateweather is a libgnomeweather fork."
CLANDRO_PKG_LICENSE="LGPL-2.1, GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mate-desktop/libmateweather/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d81e65e2bddd22edffe42a2c8748321d6f7ad2da1bce2f9c275d88c567ec29eb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libsoup3, libxml2, pango, zlib"

clandro_step_pre_configure() {
	autoreconf -fiv
}
