CLANDRO_PKG_HOMEPAGE="https://github.com/tenox7/ttyplot"
CLANDRO_PKG_DESCRIPTION="A realtime plotting utility for terminal with data input from stdin"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.4"
CLANDRO_PKG_SRCURL="https://github.com/tenox7/ttyplot/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=d4a690cb4ca6d52885ebfdc6230bfb550eecf4b8edb9b54453829a77f63ea7b9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CPPFLAGS+=" -DNCURSES_WIDECHAR=1"
	CFLAGS+=" $CPPFLAGS"
}

clandro_step_make_install() {
	install -Dm755 -t "$CLANDRO_PREFIX/bin" ttyplot
}
