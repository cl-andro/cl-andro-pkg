# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X11 Screen Saver extension library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.5"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=5057365f847253e0e275871441e10ff7846c8322a5d88e1e187d326de1cd8d00
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libx11, libxau, libxcb, libxdmcp, libxext"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
