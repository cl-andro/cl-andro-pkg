CLANDRO_PKG_HOMEPAGE=http://aspell.net/
CLANDRO_PKG_DESCRIPTION="Spanish dictionary for aspell"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="Copyright"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2:1.11-2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/aspell/dict/es/aspell6-es-${CLANDRO_PKG_VERSION:2}.tar.bz2
CLANDRO_PKG_SHA256=ad367fa1e7069c72eb7ae37e4d39c30a44d32a6aa73cedccbd0d06a69018afcc
CLANDRO_PKG_DEPENDS="aspell"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_configure() {
	cat > $CLANDRO_PKG_SRCDIR/Makefile <<- EOF
	ASPELL = $(command -v aspell)
	ASPELL_FLAGS =
	PREZIP = $(command -v prezip)
	DESTDIR =
	dictdir = $CLANDRO_PREFIX/lib/aspell-0.60
	datadir = $CLANDRO_PREFIX/lib/aspell-0.60
	EOF
	cat $CLANDRO_PKG_SRCDIR/Makefile.pre >> $CLANDRO_PKG_SRCDIR/Makefile
}
