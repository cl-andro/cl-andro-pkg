CLANDRO_PKG_HOMEPAGE=https://exiv2.org/
CLANDRO_PKG_DESCRIPTION="Exif, Iptc and XMP metadata manipulation library and tools"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2:0.28.7"
CLANDRO_PKG_SRCURL=https://github.com/Exiv2/exiv2/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=5e292b02614dbc0cee40fe1116db2f42f63ef6b2ba430c77b614e17b8d61a638
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="brotli, libandroid-support, libc++, libexpat, libiconv, libinih, zlib"
CLANDRO_PKG_BREAKS="exiv2-dev"
CLANDRO_PKG_REPLACES="exiv2-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DEXIV2_BUILD_SAMPLES=ON
"
