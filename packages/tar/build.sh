CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/tar/
CLANDRO_PKG_DESCRIPTION="GNU tar for manipulating tar archives"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.35
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/tar/tar-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=4d62ff37342ec7aed748535323930c7cf94acf71c3591882b26a7ea50f3edc16
CLANDRO_PKG_DEPENDS="libacl, libandroid-glob, libandroid-selinux, libiconv"
CLANDRO_PKG_ESSENTIAL=true

# When cross-compiling configure guesses that d_ino in struct dirent only exists
# if triplet matches linux*-gnu*, so we force set it explicitly:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="gl_cv_struct_dirent_d_ino=yes"
# this needed to disable tar's implementation of mkfifoat() so it is possible
# to use own implementation (see patch 'mkfifoat.patch').
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_mkfifoat=yes"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-acl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --with-posix-acls"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --with-selinux"

clandro_step_pre_configure() {
	CPPFLAGS+=" -D__USE_FORTIFY_LEVEL=0"
	LDFLAGS+=" -landroid-glob"
	# https://android.googlesource.com/platform/bionic/+/master/docs/32-bit-abi.md#is-32_bit-on-lp32-y2038
	if [ $CLANDRO_ARCH_BITS = 32 ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-year2038"
	fi
}
