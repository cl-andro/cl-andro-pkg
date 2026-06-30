CLANDRO_PKG_HOMEPAGE=https://www.fefe.de/gatling/
CLANDRO_PKG_DESCRIPTION="A high performance http, ftp and smb server"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.16
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=http://www.fefe.de/gatling/gatling-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=5f96438ee201d7f1f6c2e0849ff273b196bdc7493f29a719ce8ed08c8be6365b
CLANDRO_PKG_DEPENDS="libcrypt, libiconv, openssl, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libcap, libowfat"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
prefix=$CLANDRO_PREFIX
MANDIR=$CLANDRO_PREFIX/share/man
"

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lcrypt -lcrypto -liconv"
}
