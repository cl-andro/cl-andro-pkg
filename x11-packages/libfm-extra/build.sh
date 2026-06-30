## This is stripped down version of 'libfm' package.
## Primarily used for compiling 'menu-cache'.

CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/pcmanfm/
CLANDRO_PKG_DESCRIPTION="Extra library for file management"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.2
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/pcmanfm/libfm-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=a5042630304cf8e5d8cff9d565c6bd546f228b48c960153ed366a34e87cad1e5
CLANDRO_PKG_DEPENDS="glib"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-extra-only
"
