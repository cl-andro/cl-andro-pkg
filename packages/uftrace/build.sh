CLANDRO_PKG_HOMEPAGE=https://uftrace.github.io/slide
CLANDRO_PKG_DESCRIPTION="Function (graph) tracer for user-space"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.19"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/namhyung/uftrace/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=c35ef25f279684fc7d79dcc250fb29386890870fd2c9f812e587151419ca01af
# Hardcoded libpython${CLANDRO_PYTHON_VERSION}.so is dlopen(3)ed by uftrace.
# Please revbump and rebuild when bumping CLANDRO_PYTHON_VERSION.
# libandroid-{execinfo,spawn} are dlopen(3)ed.
CLANDRO_PKG_DEPENDS="capstone, libandroid-execinfo, libandroid-glob, libandroid-spawn, libc++, libdw, libelf, luajit, ncurses, python"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
# See https://github.com/termux/termux-packages/pull/21712 about arm build failure:
CLANDRO_PKG_EXCLUDED_ARCHES="arm"

# https://github.com/android/ndk/issues/1987#issuecomment-1886021103
if [ "$CLANDRO_ARCH" = "x86_64" ]; then
	CLANDRO_PKG_MAKE_PROCESSES=1
fi

clandro_step_pre_configure() {
	# uftrace uses custom configure script implementation, so we need to provide some flags
	CFLAGS+=" -DEFD_SEMAPHORE=1 -DEF_ARM_ABI_FLOAT_HARD=0x400 -w"
	LDFLAGS+=" -Wl,--wrap=_Unwind_Resume -landroid-glob -largp"

	if [ "$CLANDRO_ARCH" = "i686" ]; then
		export ARCH="i386"
	else
		export ARCH="$CLANDRO_ARCH"
	fi
}
