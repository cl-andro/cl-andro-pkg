CLANDRO_PKG_HOMEPAGE=https://www.freetype.org
CLANDRO_PKG_DESCRIPTION="Software font engine capable of producing high-quality output"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.14.3"
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/freetype/freetype-${CLANDRO_PKG_VERSION}.tar.xz
#CLANDRO_PKG_SRCURL=https://download.savannah.nongnu.org/releases/freetype/freetype-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=36bc4f1cc413335368ee656c42afca65c5a3987e8768cc28cf11ba775e785a5f
CLANDRO_PKG_DEPENDS="brotli, libbz2, libpng, zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="freetype-dev"
CLANDRO_PKG_REPLACES="freetype-dev"
# Use with-harfbuzz=no to avoid circular dependency between freetype and harfbuzz:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-harfbuzz=no"
# not install these files anymore so install them manually.
clandro_step_post_make_install() {
	install -Dm700 freetype-config $CLANDRO_PREFIX/bin/freetype-config
	install -Dm600 ../src/docs/freetype-config.1 $CLANDRO_PREFIX/share/man/man1/freetype-config.1
}
