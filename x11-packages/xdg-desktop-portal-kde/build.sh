CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/xdg-desktop-portal-kde"
CLANDRO_PKG_DESCRIPTION="A backend implementation for xdg-desktop-portal that is using Qt/KDE"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/xdg-desktop-portal-kde-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d99bdc236abfcae497727d5e48e7bbcc62641700efb0df284afef221ef878518
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kglobalaccel, kf6-kguiaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kirigami, kf6-kitemviews, kf6-knotifications, kf6-kservice, kf6-kstatusnotifieritem, kf6-kwindowsystem, kirigami-addons, kpipewire, kwayland, libc++, libwayland, libxkbcommon, plasma-workspace, qt6-qtbase, qt6-qtdeclarative, xdg-desktop-portal"
CLANDRO_PKG_BUILD_DEPENDS="cups, extra-cmake-modules, plasma-wayland-protocols, libwayland-protocols"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
