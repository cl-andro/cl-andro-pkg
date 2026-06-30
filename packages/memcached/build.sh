CLANDRO_PKG_HOMEPAGE=https://memcached.org/
CLANDRO_PKG_DESCRIPTION="Free & open source, high-performance, distributed memory object caching system"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.41"
CLANDRO_PKG_SRCURL=https://www.memcached.org/files/memcached-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e097073c156eeff9e12655b054f446d57374cfba5c132dcdbe7fac64e728286a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libevent, libsasl"
CLANDRO_PKG_BREAKS="memcached-dev"
CLANDRO_PKG_REPLACES="memcached-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-static --enable-sasl --disable-coverage"

clandro_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"

	export ac_cv_c_endian=little

	# Fix SASL configuration path
	perl -p -i -e "s#/etc/sasl#$CLANDRO_PREFIX/etc/sasl#" $CLANDRO_PKG_BUILDDIR/sasl_defs.c

	# getsubopt() taken from https://github.com/lxc/lxc/blob/master/src/include/getsubopt.c
	cp $CLANDRO_PKG_BUILDER_DIR/getsubopt.c $CLANDRO_PKG_SRCDIR
	cp $CLANDRO_PKG_BUILDER_DIR/getsubopt.h $CLANDRO_PKG_SRCDIR

	autoreconf -vfi
}
