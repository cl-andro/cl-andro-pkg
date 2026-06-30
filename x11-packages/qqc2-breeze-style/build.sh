CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/qqc2-breeze-style"
CLANDRO_PKG_DESCRIPTION="Applications useful for Plasma development"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/qqc2-breeze-style-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=24e54a1b72f5f6d2f5a5f41c4e331c8f8324f12fddf6b200d2e04ea378e46132
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcolorscheme, kf6-kconfig, kf6-kguiaddons, kf6-kiconthemes, kf6-kirigami, libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
