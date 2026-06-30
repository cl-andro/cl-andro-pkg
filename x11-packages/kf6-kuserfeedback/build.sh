CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kuserfeedback"
CLANDRO_PKG_DESCRIPTION="Framework for collecting user feedback for applications via telemetry and surveys"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kuserfeedback-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=6cc18dca65a24af2ac262cb9c8761991701c8081a7133487b4ec936003f3f864
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="clang, extra-cmake-modules, qt6-qtcharts, qt6-qtdeclarative, qt6-qtsvg, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
