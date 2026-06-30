CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kinfocenter"
CLANDRO_PKG_DESCRIPTION="A utility that provides information about a computer system"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kinfocenter-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=247f58dd25d08fa968ab83b42cb8dc76710acec54969dff31313a75566226a82
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="aha, clinfo, glu, iproute2, kf6-kauth, kf6-kcmutils, kf6-kconfig, kf6-kcoreaddons, kf6-kdeclarative, kf6-ki18n, kf6-kio, kf6-kirigami, kf6-kservice, kf6-solid, libc++, libdisplay-info, libdrm, libwayland, mesa-demos, pulseaudio, qt6-qtbase, qt6-qtdeclarative, systemsettings, vulkan-tools, xorg-xdpyinfo"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools, vulkan-headers"
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

	# for some reason repeated builds will fail to reinstall the executable if it is already present
	rm -f "$CLANDRO_PREFIX/bin/kinfocenter"
}
