CLANDRO_PKG_HOMEPAGE=https://fex-emu.com/
CLANDRO_PKG_DESCRIPTION="Fast x86 emulation frontend"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2404
CLANDRO_PKG_SRCURL=git+https://github.com/FEX-Emu/FEX
CLANDRO_PKG_GIT_BRANCH=FEX-${CLANDRO_PKG_VERSION}
CLANDRO_PKG_DEPENDS="libandroid-shmem, libc++"
CLANDRO_PKG_BUILD_DEPENDS="gdb"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686, x86_64"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DBUILD_FEXCONFIG=OFF
-DENABLE_ASSERTIONS=ON
-DENABLE_GDB_SYMBOLS=ON
-DENABLE_JEMALLOC=OFF
-DENABLE_JEMALLOC_GLIBC_ALLOC=OFF
-DENABLE_LTO=OFF
-DENABLE_OFFLINE_TELEMETRY=OFF
-DHAS_CLANG_PRESERVE_ALL=OFF
-DTUNE_ARCH=armv8-a
-DTUNE_CPU=generic
"

clandro_pkg_auto_update() {
	local latest_tag="$(clandro_github_api_get_tag "${CLANDRO_PKG_SRCURL}")"
	[[ -z "${latest_tag}" ]] && clandro_error_exit "Unable to get tag from ${CLANDRO_PKG_SRCURL}"
	clandro_pkg_upgrade_version "${latest_tag#FEX-}"
}

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem"
	find "${CLANDRO_PKG_SRCDIR}" -name '*.h' -o -name '*.c' -o -name '*.cpp' | \
		xargs -P"${CLANDRO_PKG_MAKE_PROCESSES}" -n1 \
		sed \
			-e 's:"/data/local/tmp:"'${CLANDRO_PREFIX}'/tmp:g' \
			-e 's:"/tmp:"'${CLANDRO_PREFIX}'/tmp:g' \
			-i
}
