CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/purpose'
CLANDRO_PKG_DESCRIPTION='Framework for providing abstractions to get the developers purposes fulfilled'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.25.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/purpose-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=773abfa91f50ce10419373fdb4e7e0b2be009e739f8de2f3450d3ef169b6a23e
CLANDRO_PKG_DEPENDS="kf6-kcmutils (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kio (>= ${CLANDRO_PKG_VERSION%.*}), kf6-knotifications (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kservice (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kitemmodels (>= ${CLANDRO_PKG_VERSION%.*}), kf6-prison (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase, qt6-qtdeclarative"
# kaccounts-integration, libaccounts-qt, accounts-qml-module, kcmutils can be added to CLANDRO_PKG_DEPENDS when available
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kirigami (>= ${CLANDRO_PKG_VERSION%.*}), intltool"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
