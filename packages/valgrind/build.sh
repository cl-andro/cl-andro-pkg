CLANDRO_PKG_HOMEPAGE=https://valgrind.org/
CLANDRO_PKG_DESCRIPTION="Instrumentation framework for building dynamic analysis tools"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.22.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=http://sourceware.org/pub/valgrind/valgrind-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=c811db5add2c5f729944caf47c4e7a65dcaabb9461e472b578765dd7bf6d2d4c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_DEPENDS="binutils-cross"
CLANDRO_PKG_BREAKS="valgrind-dev"
CLANDRO_PKG_REPLACES="valgrind-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-tmpdir=$CLANDRO_PREFIX/tmp"

clandro_step_pre_configure() {
	CFLAGS=${CFLAGS/-fstack-protector-strong/}

	if [ "$CLANDRO_ARCH" == "aarch64" ]; then
		cp $CLANDRO_PKG_BUILDER_DIR/aarch64-setjmp.S $CLANDRO_PKG_SRCDIR
		patch --silent -p1 < $CLANDRO_PKG_BUILDER_DIR/coregrindmake.am.diff
		patch --silent -p1 < $CLANDRO_PKG_BUILDER_DIR/memcheckmake.am.diff
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-only64bit"
	elif [ "$CLANDRO_ARCH" == "arm" ]; then
		# valgrind doesn't like arm; armv7 works, though.
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --host=armv7-linux-androideabi"
		# http://lists.busybox.net/pipermail/buildroot/2013-November/082270.html:
		# "valgrind uses inline assembly that is not Thumb compatible":
		CFLAGS=${CFLAGS/-mthumb/}
		# ```
		# <inline asm>:1:41: error: expected '%<type>' or "<type>"
		# .pushsection ".debug_gdb_scripts", "MS",@progbits,1
		#                                         ^
		# ```
		# See also https://github.com/llvm/llvm-project/issues/24438.
		clandro_setup_no_integrated_as
	fi

	autoreconf -fi
}
