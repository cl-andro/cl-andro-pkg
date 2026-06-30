CLANDRO_PKG_HOMEPAGE=https://www.capstone-engine.org/
CLANDRO_PKG_DESCRIPTION="Lightweight multi-platform, multi-architecture disassembly framework"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.0.7"
CLANDRO_PKG_SRCURL="https://github.com/capstone-engine/capstone/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=6427a724726d161d1e05fb49fff8cd0064f67836c04ffca3c11d6d859e719caa
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_BREAKS="capstone-dev"
CLANDRO_PKG_REPLACES="capstone-dev"

clandro_step_post_get_source() {
	clandro_setup_cmake

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local v=$(sed -En 's/.*VERSION_MAJOR.*[ |=]([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ -z "${v}" ]; then
		local tmpdir=$(mktemp -d)
		cmake -S "${CLANDRO_PKG_SRCDIR}" -B "${tmpdir}"
		v=$(sed -En 's/.*VERSION_MAJOR.*[ |=]([0-9]+).*/\1/p' \
			"${tmpdir}/CMakeCache.txt")
		rm -fr "${tmpdir}"
	fi
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "
		SOVERSION guard check failed!
		SOVERSION guard    = ${_SOVERSION}
		SOVERSION computed = ${v}
		"
	fi
}

clandro_step_post_make_install() {
	# build system can only build static or shared at a time
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
	-DBUILD_SHARED_LIBS=ON
	"
	clandro_step_configure
	clandro_step_make
	clandro_step_make_install
}
