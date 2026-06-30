CLANDRO_PKG_HOMEPAGE=http://www.jemarch.net/poke.html
CLANDRO_PKG_DESCRIPTION="Interactive, extensible editor for binary data."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/poke/poke-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a84cb9175d50d45a411f2481fd0662b83cb32ce517316b889cfb570819579373
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gettext, libgc, ncurses, readline"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_glob_h=no
gl_cv_func_strcasecmp_works=yes
--disable-hserver
--disable-threads
--with-sysroot=$CLANDRO_BASE_DIR
"
