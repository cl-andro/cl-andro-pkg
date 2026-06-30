CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma5support"
CLANDRO_PKG_DESCRIPTION="Porting aid to migrate from KDE Platform 5 to KDE Frameworks 6"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/plasma5support-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=30b4c1f17b8ef29e4ff519748690cc2545bbb61d71b3bc91b1ddeee981f94fd8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kholidays, kf6-ki18n, kf6-kio, kf6-kjobwidgets, kf6-kguiaddons, kf6-kservice, kf6-knotifications, kf6-kidletime, kf6-solid, kf6-kunitconversion, libc++, libxfixes, libx11, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, plasma-activities, qt6-qttools"
CLANDRO_PKG_CONFLICTS="plasma-workspace (<< 6.6.0)"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
