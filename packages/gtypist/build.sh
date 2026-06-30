CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gtypist/
CLANDRO_PKG_DESCRIPTION="Universal typing tutor"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.10.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gtypist/gtypist-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=ca618054e91f1ed5ef043fcc43500bbad701c959c31844d4688ff22849ac252d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libiconv, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_header_ncursesw_ncurses_h=yes --enable-nls=no ac_cv_header_libintl_h=no"
CLANDRO_PKG_RM_AFTER_INSTALL="share/emacs/site-lisp bin/typefortune share/man/man1/typefortune.1"
