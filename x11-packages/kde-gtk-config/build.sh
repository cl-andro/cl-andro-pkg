CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kde-gtk-config"
CLANDRO_PKG_DESCRIPTION="Syncs KDE settings to GTK applications"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kde-gtk-config-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=a82347a2e719e00409f73f2d0fc7b4f7ac4432dd31fec0e132d7bf12d06da7df
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gsettings-desktop-schemas, kdecoration, kf6-kcolorscheme, kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-kguiaddons, kf6-kwindowsystem, libc++, qt6-qtbase, qt6-qtsvg, xsettingsd"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, gtk3, sassc"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
