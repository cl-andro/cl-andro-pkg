CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kscreen"
CLANDRO_PKG_DESCRIPTION="KDE's screen management software"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kscreen-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=2f123691ac25da7f5166894ebaddda9615ddbaf949ebbb6c9829196b0615c250
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcmutils, kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-ki18n, kf6-kimageformats, kf6-kirigami, kf6-kitemmodels, kf6-ksvg, kf6-kwindowsystem, libc++, libwayland, layer-shell-qt, libkscreen, libplasma, libx11, libxcb, libxi, plasma5support, qt6-qtbase, qt6-qtdeclarative, qt6-qtsensors"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, libwayland-protocols"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
