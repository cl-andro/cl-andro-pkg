CLANDRO_PKG_HOMEPAGE=https://lftp.tech/
CLANDRO_PKG_DESCRIPTION="FTP/HTTP client and file transfer program"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.9.2
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=http://lftp.yar.ru/ftp/lftp-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=a37589c61914073f53c5da0e68bd233b41802509d758a022000e1ae2076da733
CLANDRO_PKG_DEPENDS="libandroid-support, libc++, libexpat, libiconv, openssl, readline, libidn2, zlib"

# (1) Android has dn_expand, but lftp assumes that dn_skipname then exists, which it does not on android.
# (2) Use --with-openssl to use openssl instead of gnutls.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_glob_h=no
ac_cv_func_dn_expand=no
--with-openssl=$CLANDRO_PREFIX
--with-expat=$CLANDRO_PREFIX
--with-readline=$CLANDRO_PREFIX
--with-zlib=$CLANDRO_PREFIX
"

clandro_step_pre_configure() {
	CXXFLAGS+=" -DNO_INLINE_GETPASS=1"
}
