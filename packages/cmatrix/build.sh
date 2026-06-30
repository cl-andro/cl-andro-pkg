CLANDRO_PKG_HOMEPAGE=https://github.com/abishekvashok/cmatrix
CLANDRO_PKG_DESCRIPTION="Command producing a Matrix-style animation"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/abishekvashok/cmatrix/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ad93ba39acd383696ab6a9ebbed1259ecf2d3cf9f49d6b97038c66f80749e99a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$CLANDRO_PREFIX/share/man"
CLANDRO_PKG_DEPENDS="ncurses"

clandro_step_pre_configure() {
	autoreconf -i

	export ac_cv_file__usr_lib_kbd_consolefonts=no
	export ac_cv_file__usr_share_consolefonts=no
	export ac_cv_file__usr_lib_X11_fonts_misc=no
	export ac_cv_file__usr_X11R6_lib_X11_fonts_misc=no
}
