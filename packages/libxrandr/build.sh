# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X11 RandR extension library"
CLANDRO_PKG_LICENSE="HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.5"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXrandr-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=72b922c2e765434e9e9f0960148070bd4504b288263e2868a4ccce1b7cf2767a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libx11, libxext, libxrender"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
