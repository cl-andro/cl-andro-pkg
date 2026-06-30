CLANDRO_PKG_HOMEPAGE=http://www.vanheusden.com/multitail/
CLANDRO_PKG_DESCRIPTION="Tool to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.1.5"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/folkertvanheusden/multitail/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b0c92bf5f504b39591bf3e2e30a1902925c11556e14b89a07cfa7533f9bd171b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libandroid-glob, ncurses, ncurses-ui-libs"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES="etc/multitail.conf"

clandro_step_pre_configure() {
	CFLAGS+=" -DNCURSES_WIDECHAR"
	LDFLAGS+=" -landroid-glob"
}
