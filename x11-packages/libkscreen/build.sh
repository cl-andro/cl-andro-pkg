CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/libkscreen"
CLANDRO_PKG_DESCRIPTION="KDE screen management software"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/libkscreen-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=18f8cf65fcc788a7188d72a17d6e0f107e044e07623d5c012d063d901d67b59d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libwayland, libxcb, qt6-qtbase, qt6-qtwayland"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, plasma-wayland-protocols, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
