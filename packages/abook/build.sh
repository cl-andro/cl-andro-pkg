CLANDRO_PKG_HOMEPAGE=http://abook.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://git.code.sf.net/p/abook/git
CLANDRO_PKG_GIT_BRANCH=ver_${CLANDRO_PKG_VERSION//./_}
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses, readline"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$CLANDRO_PREFIX/share/man"

clandro_step_pre_configure() {
	aclocal
	automake --add-missing
	autoreconf
}
