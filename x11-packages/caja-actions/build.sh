CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Extension for Caja which allows the user to add arbitrary programs to be launched"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/caja-actions/releases/download/v$CLANDRO_PKG_VERSION/caja-actions-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=310d39488e707fad848959a0a800b6154f4498dfddaeff5af49e4db35d0bea4d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="caja, libgtop"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, glib, mate-common"

clandro_step_pre_configure() {
	# Fixes:
	# CANNOT LINK EXECUTABLE "caja-actions-config-tool":
	# library "libna-core.so" not found: needed by main executable
	LDFLAGS+=" -Wl,-rpath=$CLANDRO_PREFIX/lib/caja-actions"
}
