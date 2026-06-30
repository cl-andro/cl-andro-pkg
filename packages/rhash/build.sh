CLANDRO_PKG_HOMEPAGE=https://github.com/rhash/RHash
CLANDRO_PKG_DESCRIPTION="Console utility for calculation and verification of magnet links and a wide range of hash sums"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/rhash/RHash/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=9f6019cfeeae8ace7067ad22da4e4f857bb2cfa6c2deaa2258f55b2227ec937a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_CONFLICTS="librhash, rhash-dev"
CLANDRO_PKG_REPLACES="librhash, rhash-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	CFLAGS="-DOPENSSL_RUNTIME -DSYSCONFDIR=\"${CLANDRO_PREFIX}/etc\" $CPPFLAGS $CFLAGS"
	./configure \
		--prefix=$CLANDRO_PREFIX \
		--disable-static \
		--enable-lib-static \
		--enable-lib-shared \
		--cc=$CC
}

clandro_step_make() {
	make -j $CLANDRO_PKG_MAKE_PROCESSES \
		ADDCFLAGS="$CFLAGS" \
		ADDLDFLAGS="$LDFLAGS"
}

clandro_step_make_install() {
	make install install-pkg-config
	make -C librhash install-lib-headers

	ln -sf $CLANDRO_PREFIX/lib/librhash.so.1 $CLANDRO_PREFIX/lib/librhash.so
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/librhash.so.1"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
