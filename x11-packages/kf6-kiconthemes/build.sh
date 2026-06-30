CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kiconthemes'
CLANDRO_PKG_DESCRIPTION='Support for icon themes'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kiconthemes-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=ed6c0c0bfed517dd5b6462d9b1c84ebe7bc99c7a75214921b5978f086df8653d
CLANDRO_PKG_DEPENDS="kf6-breeze-icons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-karchive (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcolorscheme (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfigwidgets (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwidgetsaddons (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qtsvg, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
