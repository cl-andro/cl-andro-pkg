CLANDRO_PKG_HOMEPAGE=https://www.libtom.net/LibTomMath/
CLANDRO_PKG_DESCRIPTION="A free open source portable number theoretic multiple-precision integer library"
CLANDRO_PKG_LICENSE="Unlicense"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.0"
CLANDRO_PKG_SRCURL=https://github.com/libtom/libtommath/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6d099e93ff00fa9b18346f4bcd97dcc48c3e91286f7e16c4ac5515a7171c3149
CLANDRO_PKG_AUTO_UPDATE=true
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
