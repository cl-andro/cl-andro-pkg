CLANDRO_PKG_HOMEPAGE=https://github.com/protocolbuffers/protobuf
CLANDRO_PKG_DESCRIPTION="Protocol buffers C++ library (static)"
# utf8_range is licensed under MIT
CLANDRO_PKG_LICENSE="BSD 3-Clause, MIT"
CLANDRO_PKG_LICENSE_FILE="
LICENSE
third_party/utf8_range/LICENSE
"
CLANDRO_PKG_MAINTAINER="@clandro"
# Please align the version and revision with `libprotobuf` package.
CLANDRO_PKG_VERSION=33.1
CLANDRO_PKG_SRCURL=https://github.com/protocolbuffers/protobuf/archive/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0c98bb704ceb4e68c92f93907951ca3c36130bc73f87264e8c0771a80362ac97
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="abseil-cpp, libc++, zlib"
CLANDRO_PKG_BREAKS="libprotobuf"
CLANDRO_PKG_CONFLICTS="libprotobuf, protobuf-dev"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dprotobuf_ABSL_PROVIDER=package
-Dprotobuf_BUILD_TESTS=OFF
-DBUILD_SHARED_LIBS=OFF
-DCMAKE_INSTALL_LIBDIR=lib
"

clandro_step_post_get_source() {
	# Version guard
	local ver_e=${CLANDRO_PKG_VERSION#*:}
	local ver_x=$(. $CLANDRO_SCRIPTDIR/packages/libprotobuf/build.sh; echo ${CLANDRO_PKG_VERSION#*:})
	if [ "${ver_e}" != "${ver_x}" ]; then
		clandro_error_exit "Version mismatch between libprotobuf and protobuf-static."
	fi
}

clandro_step_post_make_install() {
	# Copy lib/*.cmake to opt/protobuf-cmake/static for future use
	mkdir -p $CLANDRO_PREFIX/opt/protobuf-cmake/static
	cp $CLANDRO_PREFIX/lib/cmake/protobuf/protobuf-targets{,-release}.cmake \
		$CLANDRO_PREFIX/opt/protobuf-cmake/static/
}
