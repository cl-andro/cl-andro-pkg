CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kidletime"
CLANDRO_PKG_DESCRIPTION="Reporting of idle time of user and system"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kidletime-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=f0efd67ee0e5b5eb9200e924e9478c1ecb179b4a38e0cf125b377e7fa373ef07
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libx11, libxcb, libxext, libxss, libwayland, qt6-qtbase, qt6-qtwayland"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, libxss, libwayland-protocols, plasma-wayland-protocols, qt6-qttools, qt6-qtwayland"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
