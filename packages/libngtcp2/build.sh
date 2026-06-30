CLANDRO_PKG_HOMEPAGE=https://github.com/ngtcp2/ngtcp2
CLANDRO_PKG_DESCRIPTION="Implementation of IETF QUIC protocol"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.22.1"
CLANDRO_PKG_SRCURL="https://github.com/ngtcp2/ngtcp2/releases/download/v$CLANDRO_PKG_VERSION/ngtcp2-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=063d80531acac0ddbbc1b9d12829a824edc2abe8dba2e632fd1ce15cfd5632f9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_DEPENDS="brotli"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GNUTLS=false
-DENABLE_OPENSSL=true
-DENABLE_LIB_ONLY=true
-DHAVE_LIBBROTLIENC=true
-DHAVE_LIBBROTLIDEC=true
-DLIBBROTLIENC_LIBRARIES=$CLANDRO_PREFIX/lib/libbrotlienc.so
-DLIBBROTLIDEC_LIBRARIES=$CLANDRO_PREFIX/lib/libbrotlidec.so
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}="$(sed -nE "s/^set\(${a}\s*([0-9]+)\)/\1/p" CMakeLists.txt)"
	done

	local _SOVERSION=16 v="$(( _LT_CURRENT - _LT_AGE ))"
	if [[ ! "${_LT_CURRENT}" || "${v}" != "${_SOVERSION}" ]]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
