CLANDRO_PKG_HOMEPAGE=https://pmt.sourceforge.io/pngcrush/
CLANDRO_PKG_DESCRIPTION="Recompresses png files"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.8.13
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/pmt/pngcrush-${CLANDRO_PKG_VERSION}-nolib.tar.xz
CLANDRO_PKG_SHA256=3b4eac8c5c69fe0894ad63534acedf6375b420f7038f7fc003346dd352618350
CLANDRO_PKG_DEPENDS="libpng, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-e"

clandro_step_pre_configure() {
	export LD="$CC"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin pngcrush
}
