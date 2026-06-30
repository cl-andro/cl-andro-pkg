CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kstatusnotifieritem"
CLANDRO_PKG_DESCRIPTION="Implementation of Status Notifier Items"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.25.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kstatusnotifieritem-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=7a6397f08b15a7d50e407c193f1774b548994f6f9d12327dfbb674270adfc9af
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, kf6-kwindowsystem"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_PYTHON_BINDINGS=OFF
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
