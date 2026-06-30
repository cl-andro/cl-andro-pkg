CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Library for the X Video (Xv) extension to the X Window System"
CLANDRO_PKG_LICENSE="HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.13"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXv-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=7d34910958e1c1f8d193d828fea1b7da192297280a35437af0692f003ba03755
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libx11, libxext"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--enable-malloc0returnsnull
"
