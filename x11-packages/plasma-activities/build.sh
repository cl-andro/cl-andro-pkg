CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-activities"
CLANDRO_PKG_DESCRIPTION="Core components for KDE's Activities"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/plasma-activities-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=a1973821797c703177d51e698f8abfd8294796a9396316440b14dca958bb57e5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcoreaddons, kf6-kconfig, libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="boost, extra-cmake-modules, qt6-qtdeclarative, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
