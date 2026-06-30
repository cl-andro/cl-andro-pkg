# root-packages
CLANDRO_PKG_HOMEPAGE="https://www.aircrack-ng.org/"
CLANDRO_PKG_DESCRIPTION="WiFi security auditing tools suite"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3:1.7
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/aircrack-ng/aircrack-ng/archive/refs/tags/${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=05a704e3c8f7792a17315080a21214a4448fd2452c1b0dd5226a3a55f90b58c3
CLANDRO_PKG_DEPENDS="libc++, libnl, libpcap, libsqlite, openssl, pcre, zlib, iw, ethtool"
# static build gives errors:
#   error: undefined reference to 'ac_crypto_engine_init'
#   error: cannot find the library 'libaircrack-ce-wpa.la' or unhandled argument 'libaircrack-ce-wpa.la'
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
ac_cv_prog_RFKILL=$CLANDRO_PREFIX/bin/rfkill
--with-libpcap-include=$CLANDRO_PREFIX/include
--with-libpcap-lib=$CLANDRO_PREFIX/lib
--with-sqlite3=$CLANDRO_PREFIX
"

clandro_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}

clandro_step_post_configure() {
	local _LT_VER=$(awk '/^LT_VER =/ { print $3 }' "$CLANDRO_PKG_BUILDDIR"/Makefile)
	local m
	for m in ce-wpa osdep; do
		ln -sfr $CLANDRO_PREFIX/lib/libaircrack-${m}{-$_LT_VER,}.so
	done
}
