CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kholidays"
CLANDRO_PKG_DESCRIPTION="KDE library for regional holiday information"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kholidays-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=fc4f46cb5bb8e4766f550fe1a8b401731d797fcf6afa7cb53679048c215a60be
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qtdeclarative, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
