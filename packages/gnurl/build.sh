CLANDRO_PKG_HOMEPAGE=https://gnunet.org/en/gnurl.html
CLANDRO_PKG_DESCRIPTION="Fork of libcurl, which is mostly for GNUnet"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=7.72.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnunet/gnurl-$CLANDRO_PKG_VERSION.tar.Z
CLANDRO_PKG_SHA256=45b4e3cc1f052b2d56d076c276f65358e6f643b217d72b9a35e7a945f8601668
CLANDRO_PKG_DEPENDS="brotli, libgnutls, libidn2, libnettle, zlib, zstd"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_getpwuid=yes
--disable-dict \
--disable-file \
--disable-ftp \
--disable-gopher \
--disable-imap \
--disable-ldap \
--disable-ldaps \
--disable-ntlm-wb \
--disable-pop3 \
--disable-rtsp \
--disable-smb \
--disable-smtp \
--disable-telnet \
--disable-tftp \
--enable-ipv6 \
--enable-manual \
--enable-versioned-symbols \
--enable-threaded-resolver \
--without-gssapi \
--with-gnutls \
--without-libidn \
--without-libpsl \
--without-librtmp \
--without-ssl \
--disable-ftp \
--disable-file \
--with-random=/dev/urandom \
--with-ca-bundle=$CLANDRO_PREFIX/etc/tls/cert.pem
--with-ca-path=$CLANDRO_PREFIX/etc/tls/certs
"
