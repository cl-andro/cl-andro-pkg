CLANDRO_PKG_HOMEPAGE=https://www.stunnel.org/
CLANDRO_PKG_DESCRIPTION="Socket wrapper which can provide TLS support to ordinary applications"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.78"
CLANDRO_PKG_SRCURL=https://www.stunnel.org/downloads/stunnel-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fada662282c73923ff1c39ae7089c487694ecea92098a0e3190a81a6f492d3a0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-shared --with-ssl=$CLANDRO_PREFIX --disable-fips"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/stunnel3 share/man/man8/stunnel.*.8"
