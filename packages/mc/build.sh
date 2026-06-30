CLANDRO_PKG_HOMEPAGE=https://midnight-commander.org
CLANDRO_PKG_DESCRIPTION="Midnight Commander - a powerful file manager"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.8.33"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/MidnightCommander/mc/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=092e440930fda43574739e45a8b41af384b974e6720184b6707d127b84082c51
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="glib, libandroid-support, libssh2, ncurses, which"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_util_openpty=no
ac_cv_path_PERL=$CLANDRO_PREFIX/bin/perl
ac_cv_path_PERL_FOR_BUILD=/usr/bin/perl
ac_cv_path_PYTHON=$CLANDRO_PREFIX/bin/python
ac_cv_path_RUBY=$CLANDRO_PREFIX/bin/ruby
ac_cv_path_UNZIP=$CLANDRO_PREFIX/bin/unzip
ac_cv_path_ZIP=$CLANDRO_PREFIX/bin/zip
--with-ncurses-includes=$CLANDRO_PREFIX/include
--with-ncurses-libs=$CLANDRO_PREFIX/lib
--with-screen=ncurses
"

clandro_step_pre_configure() {
	./autogen.sh
}
