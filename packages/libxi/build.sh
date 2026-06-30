# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X11 Input extension library"
CLANDRO_PKG_LICENSE="MIT, HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXi-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=d0e0555e53d6e2114eabfa44226ba162d2708501a25e18d99cfb35c094c6c104
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libx11, libxext"
CLANDRO_PKG_BUILD_DEPENDS="libxfixes, xorgproto, xorg-util-macros"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
