# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="FreeType-based font drawing library for X"
CLANDRO_PKG_LICENSE="HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.9"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXft-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=60a25b78945ed6932635b3bb1899a517d31df7456e69867ffba27f89ff3976f5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, libx11, libxrender"
