CLANDRO_PKG_HOMEPAGE=https://www.openssl.org/
CLANDRO_PKG_DESCRIPTION="Library implementing the SSL and TLS protocols as well as general purpose cryptography functions"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:3.6.2
CLANDRO_PKG_SRCURL=https://github.com/openssl/openssl/releases/download/openssl-${CLANDRO_PKG_VERSION:2}/openssl-${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=aaf51a1fe064384f811daeaeb4ec4dce7340ec8bd893027eee676af31e83a04f
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="ca-certificates, zlib"
CLANDRO_PKG_CONFFILES="etc/tls/openssl.cnf"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/c_rehash etc/ssl/misc"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFLICTS="libcurl (<< 7.61.0-1)"
CLANDRO_PKG_BREAKS="openssl-tool (<< 1.1.1b-1), openssl-dev"
CLANDRO_PKG_REPLACES="openssl-tool (<< 1.1.1b-1), openssl-dev"

clandro_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == 'true' ]]; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	CFLAGS+=" -DNO_SYSLOG"

	sed -i "s@CLANDRO_CFLAGS@$CFLAGS@g" Configure
	rm -rf "$CLANDRO_PREFIX/lib"/libcrypto.* "$CLANDRO_PREFIX/lib"/libssl.*

	local CLANDRO_OPENSSL_PLATFORM="android-${CLANDRO_ARCH}"
	case "$CLANDRO_ARCH" in
		"arm"|"x86_64");;
		"aarch64") CLANDRO_OPENSSL_PLATFORM="android-arm64";;
		"i686") CLANDRO_OPENSSL_PLATFORM="android-x86";;
		*) clandro_error_exit "Unsupported architecture: '$CLANDRO_ARCH'"
	esac

	./Configure "$CLANDRO_OPENSSL_PLATFORM" \
		--prefix="$CLANDRO_PREFIX" \
		--openssldir="$CLANDRO_PREFIX/etc/tls" \
		shared \
		zlib-dynamic \
		no-ssl \
		no-hw \
		no-srp \
		no-tests \
		enable-tls1_3
}

clandro_step_make() {
	make depend
	make -j"$CLANDRO_PKG_MAKE_PROCESSES" all
}

clandro_step_make_install() {
	# "install_sw" instead of "install" to not install man pages:
	make -j1 install_sw MANDIR="$CLANDRO_PREFIX/share/man" MANSUFFIX=.ssl

	mkdir -p "$CLANDRO_PREFIX/etc/tls/"

	cp apps/openssl.cnf "$CLANDRO_PREFIX/etc/tls/openssl.cnf"

	sed "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
		"$CLANDRO_PKG_BUILDER_DIR/add-trusted-certificate" \
		> "$CLANDRO_PREFIX/bin/add-trusted-certificate"
	chmod 700 "$CLANDRO_PREFIX/bin/add-trusted-certificate"
}
