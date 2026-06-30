CLANDRO_PKG_HOMEPAGE=https://github.com/unknownbrackets/maxcso
CLANDRO_PKG_DESCRIPTION="A fast ISO to CSO compression program for use with PSP and PS2 emulators"
CLANDRO_PKG_LICENSE="ISC, LGPL-2.1, Apache-2.0, MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE.md, README.md"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.13.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/unknownbrackets/maxcso/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=af9c05add1a1d199ec184d3471081af1b91d591b2473800ea989c882fb632730
CLANDRO_PKG_DEPENDS="libc++, liblz4, libuv, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
}

clandro_step_post_make_install() {
	install -Dm600 -T $CLANDRO_PKG_SRCDIR/7zip/DOC/License.txt \
		$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/COPYING.7zip
	install -Dm600 -T $CLANDRO_PKG_SRCDIR/libdeflate/COPYING \
		$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/COPYING.libdeflate
	install -Dm600 -T $CLANDRO_PKG_SRCDIR/zopfli/COPYING \
		$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/COPYING.zopfli
}
