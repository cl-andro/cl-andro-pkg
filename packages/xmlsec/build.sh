CLANDRO_PKG_HOMEPAGE=https://www.aleksey.com/xmlsec/
CLANDRO_PKG_DESCRIPTION="XML Security Library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="Copyright"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.11"
CLANDRO_PKG_SRCURL=https://github.com/lsh123/xmlsec/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=bf499efd2f98a31244ad6855f327d7c3f06cc6c6447f0d2fbaea2b0103d47ecb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libgcrypt, libxml2, libnspr, libnss, libxslt, openssl"
CLANDRO_PKG_BREAKS="xmlsec-dev"
CLANDRO_PKG_REPLACES="xmlsec-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-crypto-dl
--without-gnutls
--without-pedantic
"

clandro_step_post_get_source() {
	echo >> src/openssl/symkeys.c
}

clandro_step_pre_configure() {
	autoreconf -fi
}
