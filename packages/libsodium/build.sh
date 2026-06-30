CLANDRO_PKG_HOMEPAGE=https://libsodium.org/
CLANDRO_PKG_DESCRIPTION="Network communication, cryptography and signaturing library"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.22"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/jedisct1/libsodium/archive/refs/tags/${CLANDRO_PKG_VERSION}-RELEASE.tar.gz"
CLANDRO_PKG_SHA256=5838bb0c3da6148c24ebe531d1ed1297de9a87aea77d426bcd99f289e681631c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?=-RELEASE)"
CLANDRO_PKG_BREAKS="libsodium-dev"
CLANDRO_PKG_REPLACES="libsodium-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=26

	local e=$(sed -En 's/^SODIUM_LIBRARY_VERSION=([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" = "aarch64" ]; then
		export CFLAGS_ARMCRYPTO="-march=armv8-a+crypto+aes"
	fi
}
