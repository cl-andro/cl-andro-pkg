CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kbookmarks'
CLANDRO_PKG_DESCRIPTION='Support for bookmarks and the XBEL format'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kbookmarks-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=82e8794281870686da9e7e7b5ddc0839f50b15d919357490d508faccb2635030
CLANDRO_PKG_DEPENDS="kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfigwidgets (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwidgetsaddons (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
