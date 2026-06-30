CLANDRO_PKG_HOMEPAGE=https://www.libsdl.org
CLANDRO_PKG_DESCRIPTION="Simple DirectMedia Layer 3"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.4.8"
CLANDRO_PKG_SRCURL="https://github.com/libsdl-org/SDL/releases/download/release-${CLANDRO_PKG_VERSION}/SDL3-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=e9fff7467fb60f037e6708da18b25560649e4c63edc2a69bb871b960d9cbfbba
CLANDRO_PKG_DEPENDS="libandroid-shmem, libdecor, libiconv, libwayland, libx11, libxcursor, libxext, libxfixes, libxi, libxkbcommon, libxrandr, libxss, pulseaudio"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DSDL_INSTALL_TESTS=OFF
-DSDL_TESTS=OFF
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(sed -En 's/.*SDL_SO_VERSION_MAJOR "([0-9]+)".*/\1/p' CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed: ${v} != ${_SOVERSION}"
	fi
}

clandro_step_pre_configure() {
	cp -fr "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_TMPDIR}/a"
	find "${CLANDRO_PKG_SRCDIR}" -type f -print0 | xargs -0r -n1 sed -i \
		-e 's/\([^A-Za-z0-9_]__ANDROID\)\(__[^A-Za-z0-9_]\)/\1_NO_TERMUX\2/g' \
		-e 's/\([^A-Za-z0-9_]__ANDROID\)__$/\1_NO_TERMUX__/g'
	cp -fr "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_TMPDIR}/b"
	echo "INFO: Modified files:"
	diff -uNr "${CLANDRO_PKG_TMPDIR}"/{a,b} --color || :

	LDFLAGS+=" -landroid-shmem"
}
