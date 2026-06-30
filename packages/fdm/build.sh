CLANDRO_PKG_HOMEPAGE=https://github.com/nicm/fdm
CLANDRO_PKG_DESCRIPTION="A program designed to fetch mail from POP3 or IMAP servers, or receive local mail from stdin, and deliver it in various ways"
CLANDRO_PKG_LICENSE="ISC, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE.BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.2
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/nicm/fdm/releases/download/${CLANDRO_PKG_VERSION}/fdm-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=53aad117829834e21c1b9bf20496a1aa1c0e0fb98fe7735e1e73314266fb6c16
CLANDRO_PKG_DEPENDS="libandroid-glob, libtdb, openssl, pcre2, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
--localstatedir=$CLANDRO_PREFIX/var
--disable-static
--enable-pcre2
"

clandro_step_pre_configure() {
	# Source distribution does not have separate license files
	for f in LICENSE LICENSE.BSD; do
		cp $CLANDRO_PKG_BUILDER_DIR/$f $CLANDRO_PKG_SRCDIR/
	done

	LDFLAGS+=" -landroid-glob"
}
