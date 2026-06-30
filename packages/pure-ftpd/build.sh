CLANDRO_PKG_HOMEPAGE=https://www.pureftpd.org/project/pure-ftpd
CLANDRO_PKG_DESCRIPTION="Pure-FTPd is a free (BSD), secure, production-quality and standard-conformant FTP server"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.54"
CLANDRO_PKG_SRCURL=https://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=dc9140420ec44f7829579591ff378aa6396b4604b9c6aeae847368e0f35bd7b2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcrypt, openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_elf_elf_begin=no
ac_cv_lib_sodium_crypto_pwhash_scryptsalsa208sha256_str=no
--with-ftpwho
--with-nonroot
--with-puredb
--with-tls
"
CLANDRO_PKG_CONFFILES="etc/pure-ftpd.conf"
