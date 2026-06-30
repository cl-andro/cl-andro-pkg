# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X11 miscellaneous 'fixes' extension library"
CLANDRO_PKG_LICENSE="HPND, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=6.0.2
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXfixes-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=39f115d72d9c5f8111e4684164d3d68cc1fd21f9b27ff2401b08fddfc0f409ba
CLANDRO_PKG_DEPENDS="libx11"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
CLANDRO_PKG_AUTO_UPDATE=true
