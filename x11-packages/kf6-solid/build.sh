CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/solid'
CLANDRO_PKG_DESCRIPTION='Hardware integration and detection'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/solid-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=85cfab9b0787f59478661140997c485fadab62cec535ffcef2953d312f736c4a
CLANDRO_PKG_DEPENDS="libimobiledevice, libplist, qt6-qtbase, libc++, upower, util-linux"
# media-player-info, systemd-libs, udisks2 can be added to CLANDRO_PKG_DEPENDS when available
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qtdeclarative, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_DEVICE_BACKEND_upower=ON
-DUSE_DBUS=ON
-DUDEV_DISABLED=ON
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
