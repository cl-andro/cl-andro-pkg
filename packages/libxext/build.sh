# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X11 miscellaneous extensions library"
CLANDRO_PKG_LICENSE="MIT, HPND, ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.7"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXext-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6c643c7035cdacf67afd68f25d01b90ef889d546c9fcd7c0adf7c2cf91e3a32d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
CLANDRO_PKG_DEPENDS="libx11"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
