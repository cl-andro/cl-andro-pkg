CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kglobalacceld"
CLANDRO_PKG_DESCRIPTION="Daemon providing Global Keyboard Shortcut (Accelerator) functionality"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kglobalacceld-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=c0a7ebc420c11206ffc0bea1cc4b51654fc2d235b07ccb3c5f0ae9713049d12c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kglobalaccel, kf6-kio, kf6-kjobwidgets, kf6-kservice, kf6-kwindowsystem, libc++, libx11, libxcb, qt6-qtbase, xcb-util-keysyms"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
