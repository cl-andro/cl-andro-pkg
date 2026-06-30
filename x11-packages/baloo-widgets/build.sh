CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/libraries/baloo-widgets"
CLANDRO_PKG_DESCRIPTION="Widgets for Baloo"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/baloo-widgets-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=687856a4390680ad1584ff2edf8d7eed5857be6a51ca485600b521bd82ebdcd0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-baloo, kf6-kconfig, kf6-kcoreaddons, kf6-kfilemetadata, kf6-ki18n, kf6-kio, kf6-kservice, kf6-kwidgetsaddons, libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
