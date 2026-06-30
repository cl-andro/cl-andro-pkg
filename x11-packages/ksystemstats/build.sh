CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/ksystemstats"
CLANDRO_PKG_DESCRIPTION="A plugin based system monitoring daemon"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/ksystemstats-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=31bdf29e6ba0bc5d790d1a04cb0fa9f92bb7fdf9dd8e146fe06eebb2664a7b44
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcoreaddons, kf6-kcrash, kf6-ki18n, kf6-kio, kf6-solid, libc++, libksysguard, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, libnl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
