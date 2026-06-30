CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kparts'
CLANDRO_PKG_DESCRIPTION='Document centric plugin system'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.25.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kparts-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=f0d6346e3127d1e44506733113be467d8b50cb82731d300a57990dd09baaedf1
CLANDRO_PKG_DEPENDS="kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kio (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwidgetsaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kxmlgui (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
