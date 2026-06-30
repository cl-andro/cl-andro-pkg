CLANDRO_PKG_HOMEPAGE=https://www.libtom.net/LibTomCrypt/
CLANDRO_PKG_DESCRIPTION="A fairly comprehensive, modular and portable cryptographic toolkit"
CLANDRO_PKG_LICENSE="Public Domain, WTFPL"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.18.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/libtom/libtomcrypt/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d870fad1e31cb787c85161a8894abb9d7283c2a654a9d3d4c6d45a1eba59952c
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
-f makefile.shared
PREFIX=$CLANDRO_PREFIX
"

clandro_step_pre_configure() {
	local libtooldir=$CLANDRO_PKG_TMPDIR/_libtool
	mkdir -p $libtooldir
	pushd $libtooldir
	cat > configure.ac <<-EOF
		AC_INIT
		LT_INIT
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$CLANDRO_SCRIPTDIR/scripts/config.sub" ./
	cp "$CLANDRO_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$CLANDRO_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool
}
