CLANDRO_PKG_HOMEPAGE=https://www.fvwm.org/
CLANDRO_PKG_DESCRIPTION="A multiple large virtual desktop window manager originally derived from twm."
# Licenses: GPL-2.0, FVWM
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.7.0
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://github.com/fvwmorg/fvwm/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a0662354ce5762e894665a27e59b437cb422bfe738a8cf901665c6ee0d0b9ab8
CLANDRO_PKG_DEPENDS="fontconfig, fribidi, glib, libandroid-shmem, libcairo, libice, libiconv, libpng, librsvg, libsm, libx11, libxcursor, libxext, libxft, libxinerama, libxpm, libxrender, readline"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes ac_cv_func_mkstemp=no ac_cv_func_getpwuid=no"

clandro_step_pre_configure() {
	autoreconf -fi
	export LIBS="-landroid-shmem"
}
