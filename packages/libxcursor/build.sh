# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X cursor management library"
CLANDRO_PKG_LICENSE="HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXcursor-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=fde9402dd4cfe79da71e2d96bb980afc5e6ff4f8a7d74c159e1966afb2b2c2c0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libx11, libxfixes, libxrender"
CLANDRO_PKG_BUILD_DEPENDS="xorg-util-macros"
