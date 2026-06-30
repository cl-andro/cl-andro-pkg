CLANDRO_PKG_HOMEPAGE=https://github.com/gflags/gflags
CLANDRO_PKG_DESCRIPTION="A C++ library that implements commandline flags processing"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYING.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.0"
CLANDRO_PKG_SRCURL="https://github.com/gflags/gflags/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=f619a51371f41c0ad6837b2a98af9d4643b3371015d873887f7e8d3237320b2f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BREAKS="gflags-dev"
CLANDRO_PKG_REPLACES="gflags-dev"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=ON
-DBUILD_gflags_LIBS=ON
-DINSTALL_HEADERS=ON
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2.3

	local _MAJOR=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	local _MINOR=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 2)
	local v=${_MAJOR}
	if [ "${_MAJOR}" == 2 ]; then
		v+=".${_MINOR}"
	fi
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_post_make_install() {
	#Any old packages using the library name of libgflags
	ln -sfr "$CLANDRO_PREFIX"/lib/pkgconfig/gflags.pc \
		"$CLANDRO_PREFIX"/lib/pkgconfig/libgflags.pc
}
