CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kcolorscheme'
CLANDRO_PKG_DESCRIPTION='Classes to read and interact with KColorScheme'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kcolorscheme-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=74149a0379bd8bf6590d3c1f7f8c503665e0f3adafc2adbd44fc6bb764c969f1
CLANDRO_PKG_DEPENDS="kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kguiaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
