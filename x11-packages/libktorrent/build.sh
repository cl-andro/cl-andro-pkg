CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/network/libktorrent"
CLANDRO_PKG_DESCRIPTION="A BitTorrent protocol implementation"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/libktorrent-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=2ab61b3da9bf784845c7b92da2d6d88e6422a1d87cbd639bbbce549188a20494
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-karchive, kf6-kconfig, kf6-kcoreaddons, kf6-ki18n, kf6-kio, libc++, libgmp, openssl, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="boost, extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
