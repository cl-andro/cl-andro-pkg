CLANDRO_PKG_HOMEPAGE=https://github.com/xournalpp/xournalpp
CLANDRO_PKG_DESCRIPTION="A hand note taking software"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE, copyright.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.4"
CLANDRO_PKG_SRCURL="https://github.com/xournalpp/xournalpp/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=acc261afba7b61a5556a10e03f77a141c9a4872a2529d1ed39a0f14dbc0d87db
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, gtksourceview4, libandroid-execinfo, libc++, libcairo, librsvg, libsndfile, libx11, libxi, libxml2, libzip, pango, poppler, portaudio, qpdf, zlib"
CLANDRO_PKG_REPLACES="xournal"
# Lua 5.4 would be a dependency if plugins were wanted
# Explicitly disable plugins for now to avoid prefix pollution
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_MAN=OFF
-DENABLE_PLUGINS=OFF
"

clandro_step_pre_configure() {
	CXXFLAGS+=" -Wno-c++11-narrowing"
}
