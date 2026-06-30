CLANDRO_PKG_HOMEPAGE=http://www.fftw.org/
CLANDRO_PKG_DESCRIPTION="Library for computing the Discrete Fourier Transform (DFT) in one or more dimensions"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.3.10
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=http://www.fftw.org/fftw-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467
CLANDRO_PKG_BREAKS="fftw-dev"
CLANDRO_PKG_REPLACES="fftw-dev"
# ac_cv_func_clock_gettime=no avoids having clock_gettime(CLOCK_SGI_CYCLE, &t)
# being used. It's not supported on Android but fails at runtime and, fftw
# does not check the return value so gets bogus values.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-threads ac_cv_func_clock_gettime=no"
CLANDRO_PKG_RM_AFTER_INSTALL="include/fftw*.f*"

clandro_step_post_make_install() {
	local COMMON_ARGS="$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS"
	local feature
	for feature in float long-double; do
		make clean
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="$COMMON_ARGS --enable-$feature"
		rm -Rf $CLANDRO_PKG_TMPDIR/config-scripts
		clandro_step_configure
		make -j $CLANDRO_PKG_MAKE_PROCESSES install
	done
}
