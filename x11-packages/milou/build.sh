CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/milou"
CLANDRO_PKG_DESCRIPTION="A dedicated search application built on top of Baloo"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/milou-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=23305383141927777be94e9542a0cf839cf8949286ff071e08346aa8e15a6778
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kirigami, kf6-krunner, libc++, libplasma, qt6-qtbase, qt6-qtdeclarative"
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
