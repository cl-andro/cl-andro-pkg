CLANDRO_PKG_HOMEPAGE=https://github.com/Z3Prover/z3
CLANDRO_PKG_DESCRIPTION="Z3 is a theorem prover from Microsoft Research"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.16.0"
CLANDRO_PKG_SRCURL=https://github.com/Z3Prover/z3/archive/refs/tags/z3-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c68c3e5e4810b16126b8cb4c47eee85c1ac3e24a81914c8e371b40de9dd33ac7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	# FPMATH_ENABLED=False to workaround NDK r27 issues:
	# clang++: error: unsupported option '-msse' for target 'aarch64-linux-androideabi24'
	# clang++: error: unsupported option '-msse2' for target 'armv7a-androideabi24'
	# clang++: error: unsupported option '-msimd128' for target 'i686-linux-androideabi24'
	# clang++: error: unsupported option '-msimd128' for target 'x86_64-linux-androideabi24'
	CXX="$CXX" CC="$CC" FPMATH_ENABLED=False python3 scripts/mk_make.py --prefix=$CLANDRO_PREFIX --build=$CLANDRO_PKG_BUILDDIR
	if $CLANDRO_ON_DEVICE_BUILD; then
		sed 's%../../../../../../../../%%g' -i Makefile
	else
		sed 's%../../../../../%%g' -i Makefile
	fi
}
