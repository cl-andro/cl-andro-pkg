CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="MATE Media Tools"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.1"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-media/releases/download/v$CLANDRO_PKG_VERSION/mate-media-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=bcdc102e22f63f55e63166d5c708e91c113570e6a30a874345a88609e83a9912
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcanberra, libmatemixer, mate-desktop, mate-panel, gettext"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, mate-common"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
--localstatedir=$CLANDRO_PREFIX/var
"
