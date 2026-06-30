CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/powerdevil"
CLANDRO_PKG_DESCRIPTION="Manages the power consumption settings of a Plasma Shell"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/powerdevil-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=85234e1c8402e919f33c8592af71ea3c8be1c4cd93c22c09b4b8b38467ddbf05
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, plasma-activities, kf6-kauth, kf6-kcmutils, kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kglobalaccel, kf6-ki18n, kf6-kidletime, kf6-kirigami, kf6-kitemmodels, kf6-knotifications, kf6-kservice, kf6-kxmlgui, kinfocenter, libkscreen, libplasma, libxcb, plasma-workspace, qcoro, qt6-qtbase, qt6-qtdeclarative, kf6-solid, libwayland"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools, kf6-kdoctools-cross-tools, plasma-wayland-protocols"
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
