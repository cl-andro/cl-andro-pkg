CLANDRO_PKG_HOMEPAGE=https://github.com/wez/atomicparsley
CLANDRO_PKG_DESCRIPTION="Read, parse and set metadata of MPEG-4 and 3gp files"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:20240608.083822.1ed9031"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/wez/atomicparsley/archive/${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=5bc9ac931a637ced65543094fa02f50dde74daae6c8800a63805719d65e5145e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libc++, zlib"

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin AtomicParsley
}
