CLANDRO_PKG_HOMEPAGE=http://aspell.net/
CLANDRO_PKG_DESCRIPTION="English dictionary for aspell"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="Copyright"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:2020.12.07
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/aspell/dict/en/aspell6-en-${CLANDRO_PKG_VERSION:2}-0.tar.bz2
CLANDRO_PKG_SHA256=4c8f734a28a088b88bb6481fcf972d0b2c3dc8da944f7673283ce487eac49fb3
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
