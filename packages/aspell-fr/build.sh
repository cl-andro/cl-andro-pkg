CLANDRO_PKG_HOMEPAGE=http://aspell.net/
CLANDRO_PKG_DESCRIPTION="French dictionary for aspell"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2:0.50-3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/aspell/dict/fr/aspell-fr-${CLANDRO_PKG_VERSION:2}.tar.bz2
CLANDRO_PKG_SHA256=f9421047519d2af9a7a466e4336f6e6ea55206b356cd33c8bd18cb626bf2ce91
CLANDRO_PKG_DEPENDS="aspell"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_configure() {
	cat > $CLANDRO_PKG_SRCDIR/Makefile <<- EOF
	ASPELL = $(command -v aspell)
	ASPELL_FLAGS =
	WORD_LIST_COMPRESS = $(command -v word-list-compress)
	DESTDIR =
	dictdir = $CLANDRO_PREFIX/lib/aspell-0.60
	datadir = $CLANDRO_PREFIX/lib/aspell-0.60
	EOF
	cat $CLANDRO_PKG_SRCDIR/Makefile.pre >> $CLANDRO_PKG_SRCDIR/Makefile
}
