CLANDRO_PKG_HOMEPAGE=http://www.tads.org/frobtads.htm
CLANDRO_PKG_DESCRIPTION="TADS is a free authoring system for writing your own Interactive Fiction"
CLANDRO_PKG_LICENSE="non-free"
CLANDRO_PKG_VERSION=2.0
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/realnc/frobtads/releases/download/v$CLANDRO_PKG_VERSION/frobtads-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=893bd3fd77dfdc8bfe8a96e8d7bfac693da0e4278871f10fe7faa59cc239a090
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RM_AFTER_INSTALL="share/frobtads/tads3/doc share/frobtads/tads3/lib/webuires"
CLANDRO_PKG_DEPENDS="libc++, ncurses, libcurl"
CLANDRO_PKG_LICENSE_FILE="doc/COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"
