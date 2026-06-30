CLANDRO_PKG_HOMEPAGE=https://curl.se/
CLANDRO_PKG_DESCRIPTION="Easy-to-use client-side URL transfer library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.20.0"
CLANDRO_PKG_SRCURL=https://github.com/curl/curl/releases/download/curl-${CLANDRO_PKG_VERSION//./_}/curl-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=63fe2dc148ba0ceae89922ef838f7e5c946272c2e78b7c59fab4b79d3ce2b896
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="curl-\d+_\d+_\d+(?!-)"
CLANDRO_PKG_DEPENDS="libnghttp2, libnghttp3, libngtcp2, libssh2, openssl (>= 1:3.2.1-1), zlib"
CLANDRO_PKG_BREAKS="libcurl-dev"
CLANDRO_PKG_REPLACES="libcurl-dev"
CLANDRO_PKG_ESSENTIAL=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-ntlm-wb=$CLANDRO_PREFIX/bin/ntlm_auth
--with-ca-bundle=$CLANDRO_PREFIX/etc/tls/cert.pem
--with-ca-path=$CLANDRO_PREFIX/etc/tls/certs
--with-nghttp2
--with-ngtcp2
--without-libidn
--without-libidn2
--without-librtmp
--without-brotli
--without-libpsl
--with-libssh2
--with-ssl
--with-openssl
--with-nghttp3
--disable-ares
"

# https://github.com/termux/termux-packages/issues/15889
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_getpwuid=yes"

# Starting with version 7.62 curl started enabling http/2 by default.
# Support for http/2 as added in version 1.4.8-8 of the apt package, so we
# conflict with previous versions to avoid broken installations.
CLANDRO_PKG_CONFLICTS="apt (<< 1.4.8-8)"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local a
	for a in VERSIONCHANGE VERSIONDEL; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' \
				lib/Makefile.soname)
	done
	local v=$(( _VERSIONCHANGE - _VERSIONDEL ))
	if [ ! "${_VERSIONCHANGE}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	LDFLAGS+=" -Wl,-z,nodelete"
}
