CLANDRO_PKG_HOMEPAGE=https://github.com/vasi/squashfuse
CLANDRO_PKG_DESCRIPTION="FUSE filesystem to mount squashfs archives"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/vasi/squashfuse/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7730066d1e9baf0084c71674d168331296921e0d7ae0f34de7307744be4ed568
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libfuse2, liblz4, liblzma, liblzo, zlib, zstd"

clandro_step_pre_configure () {
	./autogen.sh
}
