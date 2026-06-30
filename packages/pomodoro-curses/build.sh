CLANDRO_PKG_HOMEPAGE=https://github.com/chunga2020/pomodoro_curses
CLANDRO_PKG_DESCRIPTION="A simple pomodoro timer written with the Ncurses library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.5
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/chunga2020/pomodoro_curses/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9a0de71d1b4ba2cb3ff404e52c4eedf63afde0cc11c378663c3edd9464cd1ff8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libinih, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/pomodoro_curses
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 doc/pomodoro_curses.1
	install -Dm600 -t $CLANDRO_PREFIX/share/pomodoro-curses config-sample.ini
}
