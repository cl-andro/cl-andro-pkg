# x11-packages
CLANDRO_PKG_HOMEPAGE=https://github.com/midori-browser/core
CLANDRO_PKG_DESCRIPTION="A lightweight, fast and free web browser using WebKit and GTK+"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=9.0
CLANDRO_PKG_SRCURL=https://github.com/midori-browser/core/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=913a7cba95ddcc3dc5f6b12d861e765d6fa990fe7d4efc3768d3a3567ea460db
CLANDRO_PKG_DEPENDS="gcr, gdk-pixbuf, glib, gtk3, json-glib, libarchive, libcairo, libpeas, libsoup, libsqlite, webkit2gtk"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"

clandro_step_pre_configure() {
	clandro_setup_gir
}
