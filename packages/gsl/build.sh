CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gsl/
CLANDRO_PKG_DESCRIPTION="GNU Scientific Library (GSL) providing a wide range of mathematical routines"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.8"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gsl/gsl-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6a99eeed15632c6354895b1dd542ed5a855c0f15d9ad1326c6fe2b2c9e423190
CLANDRO_PKG_BREAKS="gsl-dev"
CLANDRO_PKG_REPLACES="gsl-dev"
# Do not remove `bin/gsl-config`
#CLANDRO_PKG_RM_AFTER_INSTALL="bin/ share/man/man1"

# Workaround for linker on Android 5 (fixed in Android 6) not supporting RTLD_GLOBAL.
# See https://github.com/termux/termux-packages/issues/507
export GSL_LDFLAGS="-Lcblas/.libs/ -lgslcblas"
