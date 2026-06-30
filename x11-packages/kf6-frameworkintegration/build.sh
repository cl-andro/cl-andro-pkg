CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/frameworkintegration"
CLANDRO_PKG_DESCRIPTION="Framework providing components to allow applications to integrate with a KDE Workspace"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/frameworkintegration-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=84ebbad39b559e271bcec4817eba9124903ca660ad4f5c3f73f21a5f4a32062d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcolorscheme, kf6-kconfig, kf6-ki18n, kf6-kiconthemes, kf6-knewstuff, kf6-knotifications, kf6-kwidgetsaddons, libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
CLANDRO_PKG_SUGGESTS="appstream-qt, packagekit-qt6"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
