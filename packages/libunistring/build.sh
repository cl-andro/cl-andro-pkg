CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/libunistring/
CLANDRO_PKG_DESCRIPTION="Library providing functions for manipulating Unicode strings"
CLANDRO_PKG_LICENSE="LGPL-3.0, GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/libunistring/libunistring-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=f245786c831d25150f3dfb4317cda1acc5e3f79a5da4ad073ddca58886569527
CLANDRO_PKG_DEPENDS="libandroid-support, libiconv"
CLANDRO_PKG_BREAKS="libunistring-dev"
CLANDRO_PKG_REPLACES="libunistring-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_uselocale=no am_cv_langinfo_codeset=yes"
