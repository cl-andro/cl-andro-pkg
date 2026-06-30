CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kdeclarative"
CLANDRO_PKG_DESCRIPTION="Provides integration of QML and KDE Frameworks"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kdeclarative-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=9a464e560e436cd3a626ca6aab894f414c6212d2de8b9c5a8eda33be213e00d8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-ki18n, kf6-kguiaddons, kf6-kwidgetsaddons, kf6-kglobalaccel, libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools, qt6-shadertools, spirv-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
