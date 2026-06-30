CLANDRO_PKG_HOMEPAGE="https://www.qt.io"
CLANDRO_PKG_DESCRIPTION="Provides access to sensor hardware and motion gesture recognition"
CLANDRO_PKG_LICENSE="GPL-3.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@termux-user"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtsensors-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=412829258bc9f42766ed13a4b9d66604f184d349510b3248ec065cf90e1fc3c7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="ninja, cmake, qt6-qtdeclarative, git"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
