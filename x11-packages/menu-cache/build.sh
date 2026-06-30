CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/lxde/
CLANDRO_PKG_DESCRIPTION="Caching mechanism for freedesktop.org compliant menus"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/lxde/menu-cache/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e8af90467df271c3c8700c840ca470ca2915699c6f213c502a87d74608748f08
CLANDRO_PKG_DEPENDS="glib, libfm-extra"

clandro_step_pre_configure() {
	CFLAGS+=" -fcommon"
	autoreconf -fi
}
