CLANDRO_PKG_HOMEPAGE=https://www.gnutls.org/
CLANDRO_PKG_DESCRIPTION="Secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them"
CLANDRO_PKG_LICENSE="LGPL-2.1, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.8.11"
CLANDRO_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/gnutls/v${CLANDRO_PKG_VERSION%.*}/gnutls-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=91bd23c4a86ebc6152e81303d20cf6ceaeb97bc8f84266d0faec6e29f17baa20
CLANDRO_PKG_DEPENDS="libc++, libgmp, libnettle, ca-certificates, libidn2, libunbound, libunistring, zlib"
CLANDRO_PKG_BREAKS="libgnutls-dev"
CLANDRO_PKG_REPLACES="libgnutls-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-cxx
--disable-hardware-acceleration
--disable-openssl-compatibility
--with-default-trust-store-file=$CLANDRO_PREFIX/etc/tls/cert.pem
--with-system-priority-file=${CLANDRO_PREFIX}/etc/gnutls/default-priorities
--with-unbound-root-key-file=$CLANDRO_PREFIX/etc/unbound/root.key
--with-included-libtasn1
--enable-local-libopts
--without-brotli
--without-p11-kit
--disable-guile
--disable-doc
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=30

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^\s*AC_SUBST\('"${a}"',\s*([0-9]+).*/\1/p' \
				m4/hooks.m4)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	CFLAGS+=" -DNO_INLINE_GETPASS=1"
}
