CLANDRO_PKG_HOMEPAGE=https://www.openssl.org/
CLANDRO_PKG_DESCRIPTION="Library implementing the SSL and TLS protocols as well as general purpose cryptography functions"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
_VERSION=1.1.1w
CLANDRO_PKG_VERSION=1:${_VERSION}
CLANDRO_PKG_SRCURL=https://www.openssl.org/source/openssl-${_VERSION/\~/-}.tar.gz
CLANDRO_PKG_SHA256=cf3098950cb4d853ad95c0841f1f9c6d3dc102dccfcacd521d93925208b76ac8
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="ca-certificates, zlib"
CLANDRO_PKG_CONFFILES="etc/tls/openssl.cnf"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/c_rehash etc/"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFLICTS="libcurl (<< 7.61.0-1)"
CLANDRO_PKG_BREAKS="openssl (<< 1.1.1m)"
CLANDRO_PKG_REPLACES="openssl (<< 1.1.1m)"

clandro_step_pre_configure() {
	test -d $CLANDRO_PREFIX/include/openssl && mv $CLANDRO_PREFIX/include/openssl{,.tmp} || :
	LDFLAGS="-L$CLANDRO_PREFIX/lib/openssl-1.1 -Wl,-rpath=$CLANDRO_PREFIX/lib/openssl-1.1 $LDFLAGS"
}

clandro_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	CFLAGS+=" -DNO_SYSLOG"

	perl -p -i -e "s@CLANDRO_CFLAGS@$CFLAGS@g" Configure
	test $CLANDRO_ARCH = "arm" && CLANDRO_OPENSSL_PLATFORM="android-arm"
	test $CLANDRO_ARCH = "aarch64" && CLANDRO_OPENSSL_PLATFORM="android-arm64"
	test $CLANDRO_ARCH = "i686" && CLANDRO_OPENSSL_PLATFORM="android-x86"
	test $CLANDRO_ARCH = "x86_64" && CLANDRO_OPENSSL_PLATFORM="android-x86_64"

	install -m755 -d $CLANDRO_PREFIX/lib/openssl-1.1

	./Configure $CLANDRO_OPENSSL_PLATFORM \
		--prefix=$CLANDRO_PREFIX \
		--openssldir=$CLANDRO_PREFIX/etc/tls \
		--libdir=$CLANDRO_PREFIX/lib/openssl-1.1 \
		shared \
		zlib-dynamic \
		no-ssl \
		no-hw \
		no-srp \
		no-tests
}

clandro_step_make() {
	make depend
	make -j $CLANDRO_PKG_MAKE_PROCESSES all
}

clandro_step_make_install() {
	# "install_sw" instead of "install" to not install man pages:
	make -j 1 install_sw MANDIR=$CLANDRO_PREFIX/share/man MANSUFFIX=.ssl

	mkdir -p $CLANDRO_PREFIX/etc/tls/

	cp apps/openssl.cnf $CLANDRO_PREFIX/etc/tls/openssl.cnf

	install -m755 -d $CLANDRO_PREFIX/include/openssl-1.1
	mv $CLANDRO_PREFIX/include/openssl $CLANDRO_PREFIX/include/openssl-1.1/
	mv $CLANDRO_PREFIX/bin/openssl $CLANDRO_PREFIX/bin/openssl-1.1
}

clandro_step_post_make_install() {
	test -d $CLANDRO_PREFIX/include/openssl.tmp && mv $CLANDRO_PREFIX/include/openssl{.tmp,} || :
}

clandro_step_post_massage() {
	rm -rf include/openssl
}
