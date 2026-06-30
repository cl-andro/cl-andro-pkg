CLANDRO_PKG_HOMEPAGE=https://lazyread.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="An auto-scroller, pager, and e-book reader all in one"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://sourceforge.net/projects/lazyread/files/lazyread/lazyread%20${CLANDRO_PKG_VERSION}/lazyread-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7e462c5c9fe104d69e410c537336af838a30a030699dd9320f75fe85a20746a1
CLANDRO_PKG_DEPENDS="coreutils, lesspipe, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	$CC $CPPFLAGS $CFLAGS lazyread.c -o lazyread $LDFLAGS -lncurses
}

clandro_step_make_install() {
	install -Dm700 lazyread $CLANDRO_PREFIX/bin/lazyread
}
