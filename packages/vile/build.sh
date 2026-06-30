CLANDRO_PKG_HOMEPAGE=https://invisible-island.net/vile/
CLANDRO_PKG_DESCRIPTION="VI Like Emacs - vi work-alike"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=9.8z
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://invisible-island.net/archives/vile/current/vile-$CLANDRO_PKG_VERSION.tgz"
CLANDRO_PKG_SHA256=0b3286c327b70a939f21992d22e42b5c1f8a6e953bd9ab9afa624ea2719272f7
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-stripping
--without-iconv
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -DGETPGRP_VOID -Wno-int-conversion"
}
