CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kcodecs"
CLANDRO_PKG_DESCRIPTION="Method collection to manipulate strings using various encodings (KDE)"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kcodecs-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=ee1fe3bd8bcd93a84d44186a5fc50395b6bf43dd2bf8972338a7aad72aa0bcb4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
