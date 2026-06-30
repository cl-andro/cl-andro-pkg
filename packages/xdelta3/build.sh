CLANDRO_PKG_HOMEPAGE=https://github.com/jmacd/xdelta
CLANDRO_PKG_DESCRIPTION='xdelta3 - VCDIFF (RFC 3284) binary diff tool'
CLANDRO_PKG_LICENSE=Apache-2.0
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.1.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/jmacd/xdelta/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7515cf5378fca287a57f4e2fee1094aabc79569cfe60d91e06021a8fd7bae29d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS=liblzma

clandro_step_post_get_source() {
	CLANDRO_PKG_SRCDIR+=/xdelta3
}

clandro_step_pre_configure() {
	autoreconf --install

	CPPFLAGS+=" -DXD3_USE_LARGEFILE64 -D_FILE_OFFSET_BITS=64"
}
