CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kquickcharts"
CLANDRO_PKG_DESCRIPTION="A QtQuick plugin providing high-performance charts"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kquickcharts-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=ae3e0784a2a2d1396cb751cc61f43a567e066d6434971246b1a18365481a1b52
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kirigami, libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-shadertools, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
