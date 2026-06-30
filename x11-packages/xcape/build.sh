CLANDRO_PKG_HOMEPAGE=https://github.com/alols/xcape
CLANDRO_PKG_DESCRIPTION="Linux utility to configure modifier keys to act as other keys when pressed and released on their own."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/alols/xcape/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a27ed884fd94f03058af65a39edfe3af3f2f8fbb76ba9920002a76be07fb2821
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BUILD_DEPENDS="libx11,libxtst"
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX"
