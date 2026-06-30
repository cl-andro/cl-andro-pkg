CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/sed/
CLANDRO_PKG_DESCRIPTION="GNU stream editor for filtering/transforming text"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.9
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/sed/sed-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6e226b732e1cd739464ad6862bd1a1aba42d7982922da7a53519631d24975181
CLANDRO_PKG_ESSENTIAL=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="base-devel"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_nl_langinfo=no
ac_cv_header_langinfo_h=no
am_cv_langinfo_codeset=no
gl_cv_func_setlocale_works=yes
"

clandro_step_pre_configure() {
	CFLAGS+=" -D__USE_FORTIFY_LEVEL=2"
}

clandro_step_post_configure() {
	touch -d "next hour" $CLANDRO_PKG_SRCDIR/doc/sed.1
}
