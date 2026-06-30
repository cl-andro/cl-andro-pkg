CLANDRO_PKG_HOMEPAGE=https://www.trustedfirmware.org/projects/mbed-tls/
CLANDRO_PKG_DESCRIPTION="Light-weight cryptographic and SSL/TLS library"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_SRCURL=git+https://github.com/Mbed-TLS/mbedtls
CLANDRO_PKG_VERSION="3.6.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_BREAKS="mbedtls-dev"
CLANDRO_PKG_REPLACES="mbedtls-dev"
CLANDRO_PKG_AUTO_UPDATE=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_STATIC_MBEDTLS_LIBRARY=OFF
-DUSE_SHARED_MBEDTLS_LIBRARY=ON
-DENABLE_TESTING=OFF
-DENABLE_PROGRAMS=OFF
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVER_crypto=16
	local _SOVER_tls=21
	local _SOVER_x509=7

	local f
	for f in crypto tls x509; do
		local v="$(sed -n 's/^SOEXT_'${f@U}'?=so\.//p' library/Makefile)"
		if [ "$(eval echo \$_SOVER_${f})" != "${v}" ]; then
			clandro_error_exit "SOVERSION guard check failed for libmbed${f}.so."
		fi
	done
}

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" = "i686" ]; then
		scripts/config.py unset MBEDTLS_AESNI_C
	fi

	# for sfml
	scripts/config.py set MBEDTLS_THREADING_C
	scripts/config.py set MBEDTLS_THREADING_PTHREAD
}
