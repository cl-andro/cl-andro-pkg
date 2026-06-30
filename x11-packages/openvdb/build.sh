CLANDRO_PKG_HOMEPAGE=https://www.openvdb.org/
CLANDRO_PKG_DESCRIPTION="Sparse volume data structure and tools"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="13.0.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=4d6a91df5f347017496fe8d22c3dbb7c4b5d7289499d4eb4d53dd2c75bb454e1
CLANDRO_PKG_DEPENDS="boost, imath, libblosc, libtbb, zlib"
CLANDRO_PKG_BUILD_DEPENDS="mesa, glfw, glu"
CLANDRO_PKG_AUTO_UPDATE=true
# Numpy support requires nanobind which is not packaged at time of writing
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DUSE_IMATH_HALF=ON
-DUSE_NUMPY=OFF
-DUSE_LOG4CPLUS=OFF
-DOPENVDB_BUILD_PYTHON_MODULE=OFF
-DOPENVDB_BUILD_DOCS=OFF
-DOPENVDB_BUILD_UNITTESTS=OFF
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=130

	local major_ver=$(sed -En 's/^set\(OpenVDB_MAJOR_VERSION\s+([0-9]+).*/\1/p' "$CLANDRO_PKG_SRCDIR"/CMakeLists.txt)
	local minor_ver=$(sed -En 's/^set\(OpenVDB_MINOR_VERSION\s+([0-9]+).*/\1/p' "$CLANDRO_PKG_SRCDIR"/CMakeLists.txt)

	if [[ "${major_ver}${minor_ver}" != "${_SOVERSION}" ]]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
