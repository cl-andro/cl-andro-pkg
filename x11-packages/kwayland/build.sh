CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kwayland"
CLANDRO_PKG_DESCRIPTION="Qt-style Client and Server library wrapper for Wayland libraries"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kwayland-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=75c4ad6743647b4a9737fddae2eddb7b0857afbef362e6b96465ccfb17c85f87
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libwayland, qt6-qtbase, qt6-qtwayland"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, libwayland-protocols, plasma-wayland-protocols, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
