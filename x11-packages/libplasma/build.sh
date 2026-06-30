CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/libplasma"
CLANDRO_PKG_DESCRIPTION="Plasma library and runtime components"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/libplasma-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=cc7dfd90b4caba4b2b4da1eb5d6c7aaa20b72b9770f511cbc433eadcc5b8e483
CLANDRO_PKG_DEPENDS="kf6-kcolorscheme, kf6-kconfig, kf6-kcoreaddons, kf6-kglobalaccel, kf6-kguiaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kirigami, kf6-knotifications, kf6-kpackage, kf6-ksvg, kf6-kwidgetsaddons, kf6-kwindowsystem, libc++, libglvnd, libwayland, libx11, libxcb, plasma-activities, qt6-qt5compat, qt6-qtbase, qt6-qtdeclarative, qt6-qtwayland"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, plasma-wayland-protocols, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
