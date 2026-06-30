CLANDRO_PKG_HOMEPAGE="https://www.openblas.net"
CLANDRO_PKG_DESCRIPTION="An optimized BLAS library based on GotoBLAS2 1.13 BSD"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.33"
CLANDRO_PKG_SRCURL="https://github.com/xianyi/OpenBLAS/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=6761af1d9f5d353ab4f0b7497be2643313b36c8f31caec0144bfef198e71e6ab
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=ON
-DC_LAPACK=ON
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" = "x86_64" ] || [ "$CLANDRO_ARCH" = "i686" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+='-DTARGET=CORE2'
	fi
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/lib/pkgconfig
	pushd $CLANDRO_PREFIX/lib
	local _lib
	for _lib in blas cblas lapack lapacke; do
		rm -f lib${_lib}.a lib${_lib}.so lib${_lib}.so.3 pkgconfig/${_lib}.pc
		ln -s libopenblas.a lib${_lib}.a
		ln -s libopenblas.so lib${_lib}.so
		ln -s libopenblas.so lib${_lib}.so.3
		ln -s openblas.pc pkgconfig/${_lib}.pc
	done
	popd # $CLANDRO_PREFIX/lib
}
