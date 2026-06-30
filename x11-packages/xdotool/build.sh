CLANDRO_PKG_HOMEPAGE=https://github.com/jordansissel/xdotool
CLANDRO_PKG_DESCRIPTION="simulate (generate) X11 keyboard/mouse input events"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.20211022.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/jordansissel/xdotool/releases/download/v${CLANDRO_PKG_VERSION}/xdotool-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=96f0facfde6d78eacad35b91b0f46fecd0b35e474c03e00e30da3fdd345f9ada
CLANDRO_PKG_DEPENDS="libx11, libxtst, libxinerama, libxkbcommon"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
INSTALLMAN=$CLANDRO_PREFIX/share/man
"
