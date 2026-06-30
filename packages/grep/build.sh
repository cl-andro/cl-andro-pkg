CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/grep/
CLANDRO_PKG_DESCRIPTION="Command which searches one or more input files for lines containing a match to a specified pattern"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="3.12"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://mirrors.kernel.org/gnu/grep/grep-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=2649b27c0e90e632eadcd757be06c6e9a4f48d941de51e7c0f83ff76408a07b9
CLANDRO_PKG_DEPENDS="libandroid-support, pcre2"
CLANDRO_PKG_ESSENTIAL=true
CLANDRO_PKG_GROUPS="base-devel"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_nl_langinfo=no
ac_cv_header_langinfo_h=no
am_cv_langinfo_codeset=no
gl_cv_func_setlocale_works=yes
"
# Avoid automagic dependency on libiconv
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" am_cv_func_iconv=no"
