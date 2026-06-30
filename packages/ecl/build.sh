CLANDRO_PKG_HOMEPAGE=https://common-lisp.net/project/ecl/
CLANDRO_PKG_DESCRIPTION="ECL (Embeddable Common Lisp) is an interpreter of the Common Lisp language"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="24.5.10"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://common-lisp.net/project/ecl/static/files/release/ecl-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=e4ea65bb1861e0e495386bfa8bc673bd014e96d3cf9d91e9038f91435cbe622b
CLANDRO_PKG_DEPENDS="libandroid-support, libgmp, libgc, libffi"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_EXCLUDED_ARCHES="i686, x86_64"
CLANDRO_PKG_HAS_DEBUG=false

# See https://gitlab.com/embeddable-common-lisp/ecl/-/blob/develop/INSTALL
# for upstream cross build guide.

# ECL needs itself during build, so we need to build it for the host first.
clandro_step_host_build() {
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix

	local srcdir=$CLANDRO_PKG_SRCDIR/src
	mkdir $_PREFIX_FOR_BUILD
	autoreconf -fi $srcdir/gmp
	$srcdir/configure ABI=${CLANDRO_ARCH_BITS} \
		CFLAGS=-m${CLANDRO_ARCH_BITS} LDFLAGS=-m${CLANDRO_ARCH_BITS} \
		--prefix=$_PREFIX_FOR_BUILD --srcdir=$srcdir --disable-c99complex
	make
	make install
}

clandro_step_pre_configure() {
	local srcdir=$CLANDRO_PKG_SRCDIR/src
	autoreconf -fi $srcdir
}

clandro_step_configure() {
	# Copy cross_config for target architecture.
	case $CLANDRO_ARCH in
		aarch64) crossconfig=android-arm64 ;;
		arm)     crossconfig=android-arm ;;
		*)       clandro_error_exit "Unsupported arch: $CLANDRO_ARCH" ;;
	esac
	crossconfig="$CLANDRO_PKG_SRCDIR/src/util/$crossconfig.cross_config"
	export ECL_TO_RUN=$CLANDRO_PKG_HOSTBUILD_DIR/prefix/bin/ecl

	local srcdir=$CLANDRO_PKG_SRCDIR/src
	$srcdir/configure \
		--srcdir=$srcdir \
		--prefix=$CLANDRO_PREFIX \
		--host=$CLANDRO_HOST_PLATFORM \
		--build=$CLANDRO_BUILD_TUPLE \
		--with-cross-config=$crossconfig \
		--disable-c99complex \
		--enable-gmp=system \
		--enable-boehm=system
}
