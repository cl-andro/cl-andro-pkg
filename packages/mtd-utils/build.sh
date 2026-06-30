CLANDRO_PKG_HOMEPAGE=http://www.linux-mtd.infradead.org/
CLANDRO_PKG_DESCRIPTION="Utilities for dealing with MTD devices"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.1"
CLANDRO_PKG_SRCURL=ftp://ftp.infradead.org/pub/mtd-utils/mtd-utils-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=03d9dc58ad10ea3549d9528f6b17a44d8944e18e96c0f31474f9f977078b83dc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="liblzo, libuuid, openssl, zlib, zstd, libandroid-execinfo"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-tests
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
}
