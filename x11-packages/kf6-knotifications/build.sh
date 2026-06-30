CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/knotifications'
CLANDRO_PKG_DESCRIPTION='Abstraction for system notifications'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/knotifications-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=2033a798856a9d2776e6e4cef6f3eb3bc24b938c0d00b06b2f6e71be44e1446a
CLANDRO_PKG_DEPENDS="kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), libc++, libcanberra, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_PYTHON_BINDINGS=OFF
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
