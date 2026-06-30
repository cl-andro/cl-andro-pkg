# Status: Termux currently uses openssl. Transitioning to libressl
#	  is tempting, but on hold for now to see how widespread
#	  the adoption of libressl in Linux distributions is.
CLANDRO_PKG_HOMEPAGE=https://www.libressl.org/
CLANDRO_PKG_DESCRIPTION="Library implementing the TLS protocol as well as general purpose cryptography functions"
CLANDRO_PKG_LICENSE="OpenSSL, ISC"
CLANDRO_PKG_MAINTEINER="@termux"
CLANDRO_PKG_VERSION=2.5.5
CLANDRO_PKG_SRCURL=https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e57f5e3d5842a81fe9351b6e817fcaf0a749ca4ef35a91465edba9e071dce7c4
CLANDRO_PKG_DEPENDS="ca-certificates"
CLANDRO_PKG_CONFLICTS="openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-openssldir=$CLANDRO_PREFIX/etc/tls"
# etc/tls/cert.pem is provided by ca-certificates:
CLANDRO_PKG_RM_AFTER_INSTALL="etc/tls/cert.pem"

clandro_step_pre_configure() {
	CPPFLAGS+=" -DNO_SYSLOG"
}
