# Contributor: @Neo-Oli
CLANDRO_PKG_HOMEPAGE=http://tsocks.sf.net
CLANDRO_PKG_DESCRIPTION="transparent network access through a SOCKS 4 or 5 proxy"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
CLANDRO_PKG_VERSION=1.8beta5
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/tsocks/tsocks/1.8%20beta%205/tsocks-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=849d7ef5af80d03e76cc05ed9fb8fa2bcc2b724b51ebfd1b6be11c7863f5b347
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS=" --with-conf=$CLANDRO_PREFIX/etc/tsocks.conf"

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_SRCDIR/tsocks-1.8/* $CLANDRO_PKG_SRCDIR/
}

clandro_step_pre_configure() {
	cp $CLANDRO_PKG_SRCDIR/tsocks.conf.complex.example $CLANDRO_PREFIX/etc/tsocks.conf
}
