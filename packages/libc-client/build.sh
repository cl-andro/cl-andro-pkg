CLANDRO_PKG_HOMEPAGE=https://www.washington.edu/imap/ # Gone.
CLANDRO_PKG_DESCRIPTION="UW IMAP c-client library"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2007f
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://www.mirrorservice.org/sites/ftp.cac.washington.edu/imap/imap-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=53e15a2b5c1bc80161d42e9f69792a3fa18332b7b771910131004eb520004a28
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" -fPIC $CPPFLAGS -DFNDELAY=O_NONBLOCK -DL_SET=SEEK_SET"
	LDFLAGS+=" -lssl -lcrypto"
}

clandro_step_configure() {
	:
}

clandro_step_make() {
	make -e slx

	mv c-client/{,lib}c-client.a
	$CC -Wl,--whole-archive c-client/libc-client.a -Wl,--no-whole-archive -shared -o c-client/libc-client.so -Wl,-soname=libc-client.so $LDFLAGS
}

clandro_step_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/lib c-client/libc-client.{a,so}
	install -Dm600 -t $CLANDRO_PREFIX/include/c-client c-client/linkage.[ch] src/c-client/*.h src/osdep/unix/*.h
	cp -a c-client/osdep.h $CLANDRO_PREFIX/include/c-client/
}
