CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Simple window management tool"
CLANDRO_PKG_LICENSE="GPL-3.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.27.0"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-netbook/releases/download/v$CLANDRO_PKG_VERSION/mate-netbook-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=b41a890c515e4dc2f51038fbc0fca65344a3b8551c7d7fd04b5470f18049df4c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libfakekey, mate-panel, gettext"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, mate-common"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
"
