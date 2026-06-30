CLANDRO_PKG_HOMEPAGE=https://github.com/bartobri/no-more-secrets
CLANDRO_PKG_DESCRIPTION="This project provides a command line tool called nms that recreates the famous data decryption effect"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.1
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/bartobri/no-more-secrets/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4422e59bb3cf62bca3c73d1fdae771b83aab686cd044f73fe14b1b9c2af1cb1b
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="all all-ncurses"

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	export NCURSES_CFLAGS="$(pkg-config --cflags ncurses)"
	export NCURSES_LIBS="$(pkg-config --libs ncurses)"
}
