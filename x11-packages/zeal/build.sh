CLANDRO_PKG_HOMEPAGE=https://zealdocs.org/
CLANDRO_PKG_DESCRIPTION="Offline documentation browser"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.1"
CLANDRO_PKG_SRCURL="https://github.com/zealdocs/zeal/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=468a2410a5edbbaa3b508f297b64fbfc725bb1477cc9a786687d24e9eb297d97
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libarchive, libc++, libsqlite, libx11, libxcb, qt6-qtbase, qt6-qtwebchannel, qt6-qtwebengine, xcb-util-keysyms"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
# error: cpp-httplib doesn't support 32-bit platforms
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DZEAL_RELEASE_BUILD=ON
"
