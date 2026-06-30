CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/print-manager"
CLANDRO_PKG_DESCRIPTION=" A tool for managing print jobs and printers"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/print-manager-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=ec44822dd2b2ecf5f26c36f9a46d5cbb3ee01d0b75ca0a2ad95f98a53d93ce6e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="cups, kf6-kcmutils, kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-ki18n, kf6-kio, kf6-kirigami, kf6-kitemmodels, kf6-knotifications, kf6-kwidgetsaddons, kf6-kwindowsystem, libc++, libplasma, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools"
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
