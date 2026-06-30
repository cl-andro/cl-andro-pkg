CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/oxygen"
CLANDRO_PKG_DESCRIPTION="KDE Oxygen style"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/oxygen-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d42522d3c34138583f3ab6a3d8077fbc77cb87a413205fed35a9d5feef9009cd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-frameworkintegration, kf6-kcmutils, kf6-kcolorscheme, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kdecoration, kf6-kguiaddons, kf6-ki18n, kf6-kwidgetsaddons, kf6-kwindowsystem, libc++, libxcb, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kirigami, libplasma"
CLANDRO_PKG_RECOMMENDS="oxygen-icons"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DBUILD_QT5=OFF
-DBUILD_QT6=ON
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
