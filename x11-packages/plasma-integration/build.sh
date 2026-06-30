CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-integration"
CLANDRO_PKG_DESCRIPTION="Qt Platform Theme integration plugins for the Plasma workspaces"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/plasma-integration-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=a31b666d2aa3a7a4f239c141e16ca66617fb94388107ccaee8e8ff1f0205a16c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcolorscheme, kf6-kcompletion, kf6-kconfig, kf6-kcoreaddons, kf6-kguiaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kjobwidgets, kf6-kservice, kf6-kstatusnotifieritem, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, qqc2-breeze-style, kf6-qqc2-desktop-style, libc++, libwayland, libxcb, libxcursor, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, plasma-wayland-protocols"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DBUILD_QT5=OFF
"
clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
