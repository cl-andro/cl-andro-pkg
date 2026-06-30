CLANDRO_PKG_HOMEPAGE=https://www.qbittorrent.org/
CLANDRO_PKG_DESCRIPTION="A Qt6 based BitTorrent client"
CLANDRO_PKG_LICENSE="GPL-2.0, GPL-3.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev>"
CLANDRO_PKG_VERSION="5.2.0"
CLANDRO_PKG_SRCURL="https://github.com/qbittorrent/qBittorrent/archive/refs/tags/release-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=543c657362d7aaf712ccb28e80236de3b7685235112122c06d69c6a8b68ef0e0
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtsvg, qt6-qttools, boost"
CLANDRO_PKG_DEPENDS="libc++, libtorrent-rasterbar, openssl, qt6-qtbase, zlib"
CLANDRO_PKG_RECOMMENDS="python"
CLANDRO_PKG_SUGGESTS="jackett"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+\.\d+\.\d+(?!beta|rc)'
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS='
-DBUILD_SHARED_LIBS=OFF
-DCMAKE_BUILD_TYPE=Release
-DSTACKTRACE=OFF
'

# based on the secondary `-shared` build in `libncnn`
clandro_step_post_make_install() {
	echo -e "termux - building qbittorrent-nox for arch ${CLANDRO_ARCH}..."
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+='-DGUI=OFF'
	clandro_step_configure
	clandro_step_make
	clandro_step_make_install
}
