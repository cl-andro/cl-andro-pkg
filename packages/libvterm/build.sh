CLANDRO_PKG_HOMEPAGE=https://www.leonerd.org.uk/code/libvterm/
CLANDRO_PKG_DESCRIPTION="Terminal emulator library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:0.3.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.leonerd.org.uk/code/libvterm/libvterm-${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=09156f43dd2128bd347cbeebe50d9a571d32c64e0cf18d211197946aff7226e0
CLANDRO_PKG_BREAKS="libvterm-dev"
CLANDRO_PKG_REPLACES="libvterm-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	make src/encoding/DECdrawing.inc src/encoding/uk.inc
}

clandro_step_make_install() {
	cd $CLANDRO_PKG_SRCDIR/src
	$CC -std=c99 -shared -fPIC $LDFLAGS -o $CLANDRO_PREFIX/lib/libvterm.so \
		-Wl,-soname=libvterm.so *.c -I../include -I.
	cp ../include/*.h $CLANDRO_PREFIX/include/
}
