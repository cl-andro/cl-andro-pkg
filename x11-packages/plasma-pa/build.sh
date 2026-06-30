CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-pa"
CLANDRO_PKG_DESCRIPTION="Plasma applet for audio volume management using PulseAudio"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/plasma-pa-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=e7062b86e728033b1125c711ec5bb285d2028c642f9775347624a1607f694793
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, kf6-kcmutils, kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-kdeclarative, kf6-kglobalaccel, kf6-ki18n, kf6-kirigami, kf6-kitemmodels, kf6-kstatusnotifieritem, kf6-ksvg, libc++, libcanberra, libplasma, plasma-workspace, pulseaudio, pulseaudio-qt, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_DOC=OFF
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
