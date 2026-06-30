CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/attica'
CLANDRO_PKG_DESCRIPTION='Qt library that implements the Open Collaboration Services API'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/attica-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=eb2d3d2d8b12c2ab4d192c4ae6f07b0188a40aa002b3056db6369b47b2f9df96
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
