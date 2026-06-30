CLANDRO_PKG_HOMEPAGE=https://cmake.org/
CLANDRO_PKG_DESCRIPTION="Family of tools designed to build, test and package software"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE.rst"
CLANDRO_PKG_MAINTAINER="@clandro"
# When updating version here, please update clandro_setup_cmake.sh as well.
CLANDRO_PKG_VERSION="4.3.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://www.cmake.org/files/v${CLANDRO_PKG_VERSION:0:3}/cmake-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=b0231eb39b3c3cabdc568c619df78208a7bd95ea10c9b2236d61218bac1b367d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libarchive, libc++, libcurl, libexpat, jsoncpp, libuv, rhash, zlib"
CLANDRO_PKG_RECOMMENDS="clang, make"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DSPHINX_MAN=ON
-DCMAKE_MAN_DIR=share/man
-DCMAKE_DOC_DIR=share/doc/cmake
-DCMAKE_USE_SYSTEM_CURL=ON
-DCMAKE_USE_SYSTEM_EXPAT=ON
-DCMAKE_USE_SYSTEM_FORM=ON
-DCMAKE_USE_SYSTEM_JSONCPP=ON
-DCMAKE_USE_SYSTEM_LIBARCHIVE=ON
-DCMAKE_USE_SYSTEM_LIBRHASH=ON
-DCMAKE_USE_SYSTEM_LIBUV=ON
-DCMAKE_USE_SYSTEM_ZLIB=ON
-DBUILD_CursesDialog=ON
"

clandro_pkg_auto_update() {
	local CLANDRO_SETUP_CMAKE="${CLANDRO_SCRIPTDIR}/scripts/build/setup/clandro_setup_cmake.sh"
	local latest_version=$(clandro_repology_api_get_latest_version "${CLANDRO_PKG_NAME}")
	if [[ "${latest_version}" == "null" ]]; then
		latest_version="${CLANDRO_PKG_VERSION}"
	fi
	if [[ "${latest_version}" == "${CLANDRO_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi

	local CLANDRO_CMAKE_TARNAME="cmake-${latest_version}-linux-x86_64.tar.gz"
	local CLANDRO_CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v${latest_version}/${CLANDRO_CMAKE_TARNAME}"
	local CLANDRO_CMAKE_TARFILE=$(mktemp)
	curl -Ls "${CLANDRO_CMAKE_URL}" -o "${CLANDRO_CMAKE_TARFILE}"
	local CLANDRO_CMAKE_SHA256=$(sha256sum "${CLANDRO_CMAKE_TARFILE}" | cut -d" " -f1)

	if [[ "${BUILD_PACKAGES}" == "false" ]]; then
		echo "INFO: package needs to be updated to ${latest_version}."
		return
	fi

	sed \
		-e "s|local CLANDRO_CMAKE_VERSION=.*|local CLANDRO_CMAKE_VERSION=${latest_version}|" \
		-e "s|local CLANDRO_CMAKE_SHA256=.*|local CLANDRO_CMAKE_SHA256=${CLANDRO_CMAKE_SHA256}|" \
		-i "${CLANDRO_SETUP_CMAKE}"
	rm -f "${CLANDRO_CMAKE_TARFILE}"

	clandro_pkg_upgrade_version "${latest_version}"
}
