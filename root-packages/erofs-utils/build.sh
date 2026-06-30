CLANDRO_PKG_HOMEPAGE=https://github.com/erofs/erofs-utils
CLANDRO_PKG_DESCRIPTION="A github erofs-utils fork for community development"
CLANDRO_PKG_LICENSE="GPL-2.0, Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, LICENSES/GPL-2.0, LICENSES/Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9.1"
CLANDRO_PKG_SRCURL=https://github.com/erofs/erofs-utils/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a9ef5ab67c4b8d2d3e9ed71f39cd008bda653142a720d8a395a36f1110d0c432
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="liblz4, liblzma, libfuse2, libuuid, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--prefix=$CLANDRO_PREFIX --enable-lzma --enable-fuse"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	./autogen.sh
}
