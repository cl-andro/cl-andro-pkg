CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kjobwidgets'
CLANDRO_PKG_DESCRIPTION='Widgets for tracking KJob instances'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kjobwidgets-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=8057b7bd132cc2b469ac406f95ba22bc3cfc240c1031485f19fa072ab942f71e
CLANDRO_PKG_DEPENDS="kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-knotifications (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwidgetsaddons (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_PYTHON_BINDINGS=OFF
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
