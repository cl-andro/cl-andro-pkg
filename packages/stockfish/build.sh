CLANDRO_PKG_HOMEPAGE=https://stockfishchess.org/
CLANDRO_PKG_DESCRIPTION="Free and strong UCI chess engine"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="18"
CLANDRO_PKG_SRCURL="https://github.com/official-stockfish/Stockfish/archive/refs/tags/sf_${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=22a195567e3493e7c9ca8bf8fa2339f4ffc876384849ac8a417ff4b919607e7b
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
-C src
COMP=clang
PREFIX=$CLANDRO_PREFIX
"

clandro_step_configure() {
	local TARGET_ARCH
	# 64-bit ARM Android 7.0 is thought to require CPUs with at least armv8 instructions, but not more
	# 32-bit ARM Android 7.0 is thought to require CPUs with at least armv7-neon instructions, but not more
	# 64-bit x86 Android 7.0 is thought to require CPUs with at least x86-64-sse41-popcnt instructions, but not more
	# 32-bit x86 Android 7.0 is thought to require CPUs with at least x86-32-sse2 instructions, but not more
	case "$CLANDRO_ARCH" in
		'aarch64') TARGET_ARCH='armv8';;
		'arm')     TARGET_ARCH='armv7-neon';;
		'x86_64')  TARGET_ARCH='x86-64-sse41-popcnt';;
		'i686')    TARGET_ARCH='x86-32-sse2';;
		*) clandro_error_exit "Architecture not supported by build system"
	esac
	CLANDRO_PKG_EXTRA_MAKE_ARGS+=" ARCH=$TARGET_ARCH COMPCXX=$CXX STRIP=$STRIP"
}

clandro_step_make() {
	make net   $CLANDRO_PKG_EXTRA_MAKE_ARGS -j"$CLANDRO_PKG_MAKE_PROCESSES"
	make build $CLANDRO_PKG_EXTRA_MAKE_ARGS -j"$CLANDRO_PKG_MAKE_PROCESSES"
}
