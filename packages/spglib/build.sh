CLANDRO_PKG_HOMEPAGE="https://spglib.github.io/spglib/index.html"
CLANDRO_PKG_DESCRIPTION="C library for finding and handling crystal symmetries"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7.0"
CLANDRO_PKG_SRCURL="https://github.com/spglib/spglib/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=b22fc9abae9716c574fbc6d55cfc53ed654a714fccc5657a26ff5d18114bd8bd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DSPGLIB_USE_OMP=ON
-DSPGLIB_WITH_Fortran=OFF
"

clandro_step_pre_configure() {
	LDFLAGS+=" -fopenmp -static-openmp"
}
