CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/sharutils/
CLANDRO_PKG_DESCRIPTION="Utilities for packaging and unpackaging shell archives"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.15.2
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/sharutils/sharutils-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=2b05cff7de5d7b646dc1669bc36c35fdac02ac6ae4b6c19cb3340d87ec553a9a
CLANDRO_PKG_DEPENDS="libandroid-support"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_spawn_h=no
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"
}
