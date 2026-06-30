CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kpeople"
CLANDRO_PKG_DESCRIPTION="A library that provides access to all contacts and the people who hold them"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kpeople-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=bd1092cd9900d0ee3b3d08d0971e669a82d1a11c9bec6e2322d713b59191b873
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcontacts, kf6-kcoreaddons, kf6-ki18n, kf6-kitemviews, kf6-kwidgetsaddons, libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qtdeclarative, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
