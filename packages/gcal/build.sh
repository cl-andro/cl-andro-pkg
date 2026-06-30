CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gcal/
CLANDRO_PKG_DESCRIPTION="Program for calculating and printing calendars"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.1
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gcal/gcal-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=91b56c40b93eee9bda27ec63e95a6316d848e3ee047b5880ed71e5e8e60f61ab
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-threads
ac_cv_header_spawn_h=no
"

clandro_step_pre_configure() {
	autoreconf -fi
}
