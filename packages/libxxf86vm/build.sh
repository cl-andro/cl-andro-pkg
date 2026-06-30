CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X11 XFree86 video mode extension library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.7"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXxf86vm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=ae50c0f669e0af5a67cc4cd0f54f21d64a64d2660af883e80e95d3fe51b945d8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libx11, libxext"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--enable-malloc0returnsnull
"
