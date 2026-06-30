CLANDRO_PKG_HOMEPAGE=https://www.zlib.net/pigz
CLANDRO_PKG_DESCRIPTION="Parallel implementation of the gzip file compressor"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.8
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/madler/pigz/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=SKIP_CHECKSUM
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 pigz $CLANDRO_PREFIX/bin/pigz
	ln -sfr $CLANDRO_PREFIX/bin/pigz $CLANDRO_PREFIX/bin/unpigz
	install -Dm600 pigz.1 $CLANDRO_PREFIX/share/man/man1/pigz.1
}
