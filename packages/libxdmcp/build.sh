# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X11 Display Manager Control Protocol library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.5"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/lib/libXdmcp-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=d8a5222828c3adab70adf69a5583f1d32eb5ece04304f7f8392b6a353aa2228c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
