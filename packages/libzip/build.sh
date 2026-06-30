CLANDRO_PKG_HOMEPAGE=https://libzip.org/
CLANDRO_PKG_DESCRIPTION="Library for reading, creating, and modifying zip archives"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.11.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/nih-at/libzip/releases/download/v$CLANDRO_PKG_VERSION/libzip-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=82e9f2f2421f9d7c2466bbc3173cd09595a88ea37db0d559a9d0a2dc60dc722e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libbz2, liblzma, openssl, zlib, zstd"
CLANDRO_PKG_BREAKS="libzip-dev"
CLANDRO_PKG_REPLACES="libzip-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GNUTLS=NO
-DENABLE_MBEDTLS=NO
-DENABLE_OPENSSL=YES
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local v=$(sed -En 's/^\s*set_target_properties\(zip\s+.*\s+SOVERSION\s+([0-9]+).*/\1/p' \
			lib/CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
