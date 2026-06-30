CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/libraries/kweathercore"
CLANDRO_PKG_DESCRIPTION="Library to facilitate retrieval of weather information including forecasts and alerts"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/kweathercore-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=fc3ac8c0c5f0ae5a2a43f9587d7e811d53d4ffafba1de3ee02ab55105a0a536c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kholidays, kf6-ki18n, libc++, qt6-qtbase, qt6-qtpositioning"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qtdeclarative"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
" 
