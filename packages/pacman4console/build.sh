CLANDRO_PKG_HOMEPAGE=https://sites.google.com/site/doctormike/pacman.html
CLANDRO_PKG_DESCRIPTION="A 9 level ncurses pacman game with editor"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://ftp.debian.org/debian/pool/main/p/pacman4console/pacman4console_${CLANDRO_PKG_VERSION}.orig.tar.gz
CLANDRO_PKG_SHA256=9a5c4a96395ce4a3b26a9896343a2cdf488182da1b96374a13bf5d811679eb90
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/share/man/man1 "$CLANDRO_PREFIX"/share/man/man6
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/pacmanedit.1 "$CLANDRO_PREFIX"/share/man/man1/
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/pacman.6 "$CLANDRO_PREFIX"/share/man/man6/
}
