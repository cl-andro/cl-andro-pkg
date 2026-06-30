CLANDRO_PKG_HOMEPAGE="https://www.qt.io/"
CLANDRO_PKG_DESCRIPTION="Provides access to Bluetooth hardware"
CLANDRO_PKG_LICENSE="GPL-3.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtconnectivity-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=c0f0c124c849ef811a873bf1a0123e3feabac6e9ca3ea7e7ac7a40543ec6193a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libpcsclite, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="cmake, git, ninja"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
