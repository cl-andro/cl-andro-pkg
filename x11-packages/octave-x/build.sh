CLANDRO_PKG_HOMEPAGE=https://octave.org
CLANDRO_PKG_DESCRIPTION="GNU Octave is a high-level language, primarily intended for numerical computations"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2:10.3.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://ftpmirror.gnu.org/octave/octave-${CLANDRO_PKG_VERSION#*:}.tar.xz"
CLANDRO_PKG_SHA256=92ae9bf2edcd288bd2df9fd0b4f7aa719b49d3940fceb154c5fdcd846f254da1
CLANDRO_PKG_DEPENDS="arpack-ng, clang, fftw, fltk, fontconfig, freetype, ghostscript, glpk, glu, graphicsmagick, libandroid-complex-math, libbz2, libc++, libcurl, libhdf5, libiconv, libopenblas, libsndfile, libx11, libxcursor, libxext, libxfixes, libxft, libxinerama, libxrender, make, opengl, openssl, pcre2, portaudio, qhull, qrupdate-ng, qscintilla-qt6, qt6-qt5compat, qt6-qtbase, qt6-qttools, readline, suitesparse, sundials, zlib"
CLANDRO_PKG_BUILD_DEPENDS="gnuplot, less, rapidjson, qt6-qtbase-cross-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_RECOMMENDS="gnuplot, less"
CLANDRO_PKG_CONFLICTS="octave"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-x
--with-qt=6
--disable-java
--enable-link-all-dependencies
--disable-openmp
--with-blas=openblas
--with-openssl=yes
--with-libiconv-prefix=$CLANDRO_PREFIX
--enable-fortran-calling-convention=f2c
ac_cv_header_glob_h=no
ac_cv_func_endpwent=no
ac_cv_func_getegid=no
ac_cv_func_geteuid=no
ac_cv_func_getgrent=no
ac_cv_func_getgrgid=no
ac_cv_func_getgrnam=no
ac_cv_func_getpwent=no
ac_cv_func_getpwnam=no
ac_cv_func_getpwnam_r=no
ac_cv_func_getpwuid=no
ac_cv_func_setgrent=no
ac_cv_func_setpwent=no
ac_cv_func_setpwuid=no
"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_post_get_source() {
	# Version guard
	local ver_e=${CLANDRO_PKG_VERSION#*:}
	local ver_x=$(. $CLANDRO_SCRIPTDIR/packages/octave/build.sh; echo ${CLANDRO_PKG_VERSION#*:})
	if [ "${ver_e}" != "${ver_x}" ]; then
		clandro_error_exit "Version mismatch between octave and octave-x."
	fi
}

clandro_step_pre_configure() {
	clandro_setup_flang

	local flang_toolchain_dir="$(dirname $(dirname $(command -v flang-new)))"
	local flang_libs_dir="$flang_toolchain_dir/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM"

	export F77="$FC"
	mkdir -p $CLANDRO_PKG_TMPDIR/_deps
	ln -sf $flang_libs_dir/libFortranRuntime.a $CLANDRO_PKG_TMPDIR/_deps/
	ln -sf $flang_libs_dir/libFortranDecimal.a $CLANDRO_PKG_TMPDIR/_deps/
	export ac_cv_f77_libs="-L$CLANDRO_PKG_TMPDIR/_deps -l:libFortranRuntime.a -l:libFortranDecimal.a"

	LDFLAGS+=" -Wl,-rpath,$CLANDRO_PREFIX/lib/octave/$CLANDRO_PKG_VERSION"
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	# put -l:$_libgcc_name only in $LIBS instead of $LDFLAGS
	export LIBS="-landroid-complex-math -L$_libgcc_path -l:$_libgcc_name"

	export PATH="$CLANDRO_PREFIX/opt/qt6/cross/bin:$PATH"
}
