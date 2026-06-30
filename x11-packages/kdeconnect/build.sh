CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/network/kdeconnect-kde"
CLANDRO_PKG_DESCRIPTION="Adds communication between KDE and your smartphone"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/kdeconnect-kde-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=c58277e16caac9e440211ce82cd07ca874d6f47ebdea58c44d237b5b84e3a538
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus, kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kdeclarative, kf6-kguiaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kirigami, kf6-kitemmodels, kf6-kjobwidgets, kf6-knotifications, kf6-kpeople, kf6-kservice, kf6-kstatusnotifieritem, kf6-kwindowsystem, kirigami-addons, libei, libfakekey, libx11, libxkbcommon, libxtst, openssl, pulseaudio-qt, kf6-qqc2-desktop-style, qt6-qtbase, qt6-qtconnectivity, qt6-qtdeclarative, qt6-qtmultimedia, qt6-qtwayland, kf6-solid, libc++, libwayland"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kpackage, qt6-qtdeclarative, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
