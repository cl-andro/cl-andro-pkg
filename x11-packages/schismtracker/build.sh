CLANDRO_PKG_HOMEPAGE=https://schismtracker.org/
CLANDRO_PKG_DESCRIPTION="A free and open-source reimplementation of Impulse Tracker, a program used to create high quality music"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="20251014"
CLANDRO_PKG_SRCURL=https://github.com/schismtracker/schismtracker/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=84e9977770a131f3bbc699c2d6cae8b3471e44a4ae1e62024f697caa6bf19d96
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libflac, libx11, libxv, sdl2 | sdl2-compat, utf8proc"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_prog_WINDRES=
ac_cv_prog_ac_ct_WINDRES=
"

clandro_step_pre_configure() {
	autoreconf -fi -I$CLANDRO_PREFIX/share/aclocal
}

clandro_step_post_configure() {
	mkdir -p auto
}
