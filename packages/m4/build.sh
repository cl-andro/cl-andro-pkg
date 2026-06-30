CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/m4/m4.html
CLANDRO_PKG_DESCRIPTION="Traditional Unix macro processor"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.4.19
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/m4/m4-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96
CLANDRO_PKG_BUILD_DEPENDS="libandroid-spawn"
CLANDRO_PKG_GROUPS="base-devel"
CLANDRO_PKG_EXTRA_MAKE_ARGS="
HELP2MAN=:
"
# Avoid automagic dependency on libiconv
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" am_cv_func_iconv=no"

clandro_step_pre_configure() {
	CPPFLAGS+=" -D__USE_FORTIFY_LEVEL=0"
}
