CLANDRO_PKG_HOMEPAGE=https://gmplib.org/
CLANDRO_PKG_DESCRIPTION="Library for arbitrary precision arithmetic"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.3.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gmp/gmp-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=a3c2b80201b89e68616f4ad30bc66aee4927c3ce50e33929ca819d5c43538898
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BREAKS="libgmp-dev"
CLANDRO_PKG_REPLACES="libgmp-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-cxx"

clandro_step_pre_configure() {
	# the cxx tests fail because it won't link properly without this
	CXXFLAGS+=" -L$CLANDRO_PREFIX/lib -Wl,-rpath=$CLANDRO_PREFIX/lib"
}
