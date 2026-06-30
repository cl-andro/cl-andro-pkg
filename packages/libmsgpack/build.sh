CLANDRO_PKG_HOMEPAGE=https://github.com/msgpack/msgpack-c/
CLANDRO_PKG_DESCRIPTION="MessagePack implementation for C"
CLANDRO_PKG_LICENSE="BSL-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.1.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/msgpack/msgpack-c/releases/download/c-${CLANDRO_PKG_VERSION}/msgpack-c-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=674119f1a85b5f2ecc4c7d5c2859edf50c0b05e0c10aa0df85eefa2c8c14b796
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="c-\d+\.\d+\.\d+"
CLANDRO_PKG_BREAKS="libmsgpack-dev"
CLANDRO_PKG_REPLACES="libmsgpack-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DMSGPACK_BUILD_EXAMPLES=OFF
-DMSGPACK_BUILD_TESTS=OFF
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(sed -En 's/^\s*SET_TARGET_PROPERTIES\s*\(msgpack-c\s+.*\s+SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
