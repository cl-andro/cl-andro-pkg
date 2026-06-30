CLANDRO_PKG_HOMEPAGE=https://www.deepspace6.net/projects/ipv6calc.html
CLANDRO_PKG_DESCRIPTION="Does some format changes and calculations of IPv6 addresses"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.4.0"
CLANDRO_PKG_SRCURL=https://github.com/pbiering/ipv6calc/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6863540b173804e5b99cb2c1b14e600170ce9af0b462fcad41584c316d19a310
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl, perl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-external-db=$CLANDRO_PREFIX/share/ipv6calc/db
--with-dbip-db=$CLANDRO_PREFIX/share/DBIP
--with-ip2location-db=$CLANDRO_PREFIX/share/IP2Location
"
CLANDRO_PKG_EXTRA_MAKE_ARGS="exec_prefix=$CLANDRO_PREFIX"

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lcrypto -lm"
}
