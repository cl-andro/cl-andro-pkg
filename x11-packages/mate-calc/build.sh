CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="This is the MATE calculator application"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-calc/releases/download/v$CLANDRO_PKG_VERSION/mate-calc-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=804b125d1e2864b1e74af816da9b2ab8b19472b9af974437ee7355ada5e628f5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk3, libmpc, libxml2"
CLANDRO_PKG_BUILD_DEPENDS="mate-common"

clandro_step_pre_configure() {
	# prevents error: unknown type name 'ulong'
	CFLAGS+=" -Dulong=u_long"
}
