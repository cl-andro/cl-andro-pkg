CLANDRO_PKG_HOMEPAGE=http://jubalh.github.io/nudoku/
CLANDRO_PKG_DESCRIPTION="ncurses based sudoku game"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.0.0"
CLANDRO_PKG_SRCURL=https://github.com/jubalh/nudoku/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=061ef63cd4754e22024fbfbc5fc103de9e4a90ffe21790a3433c8af770e6da09
CLANDRO_PKG_DEPENDS="libcairo, ncurses"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-cairo
"

clandro_step_pre_configure() {
	autoreconf -i
}
