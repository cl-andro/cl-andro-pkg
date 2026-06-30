CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gnuit/
CLANDRO_PKG_DESCRIPTION="gnuit - GNU Interactive Tools"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.9.5
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnuit/gnuit-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6b6e96db13bafa5ad35c735b2277699d4244088c709a3e134fb1a3e8c8a8557c
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-transition"
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses"

clandro_step_post_massage() {
	cd $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/share/gnuit
	ln -s gnuitrc.xterm-color gnuitrc.xterm-256color
	ln -s gnuitrc.screen gnuitrc.screen-color
	ln -s gnuitrc.screen gnuitrc.screen-256color
}
