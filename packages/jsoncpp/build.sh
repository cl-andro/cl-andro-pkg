CLANDRO_PKG_HOMEPAGE=https://github.com/open-source-parsers/jsoncpp
CLANDRO_PKG_DESCRIPTION="C++ library for interacting with JSON"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9.7"
CLANDRO_PKG_SRCURL=https://github.com/open-source-parsers/jsoncpp/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=830bf352d822d8558e9d0eb19d640d2e38536b4b6699c30a4488da09d5b1df18
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BREAKS="jsoncpp-dev"
CLANDRO_PKG_REPLACES="jsoncpp-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DBUILD_OBJECT_LIBS=OFF
-DJSONCPP_WITH_TESTS=OFF
-DCCACHE_FOUND=OFF
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=27

	local v=$(sed -En 's/^set\(PROJECT_SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	# The installation does not overwrite symlinks such as libjsoncpp.so.1,
	# so if rebuilding these are not detected as modified. Fix that:
	rm -f $CLANDRO_PREFIX/lib/libjsoncpp.so*
}
