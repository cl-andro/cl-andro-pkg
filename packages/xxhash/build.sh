CLANDRO_PKG_HOMEPAGE=https://cyan4973.github.io/xxHash/
CLANDRO_PKG_DESCRIPTION="Extremely fast non-cryptographic hash algorithm"
CLANDRO_PKG_LICENSE="BSD, GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Cyan4973/xxHash/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=aae608dfe8213dfd05d909a57718ef82f30722c392344583d3f39050c7f29a80
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libxxhash.so.0"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
