CLANDRO_PKG_HOMEPAGE=https://flameshot.org/
CLANDRO_PKG_DESCRIPTION="Powerful yet simple to use screenshot software"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="13.3.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/flameshot-org/flameshot/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bd1666313c875400e9588b47eb3fd2f4d0828460b3705a215b97746ea654c1b4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DDISABLE_UPDATE_CHECKER=OFF
-DUSE_WAYLAND_CLIPBOARD=OFF
"
# remove include and lib after make install to prevent conflicts and
# in sync with upstream's suggested Debian packaging script:
# https://github.com/flameshot-org/flameshot/blob/0ad3357a7675c11d462ec2e6752b04b285eeb658/packaging/debian/rules#L29
# https://github.com/termux/termux-packages/issues/29113
CLANDRO_PKG_RM_AFTER_INSTALL="
include
lib
"
