CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-systemmonitor"
CLANDRO_PKG_DESCRIPTION="An interface for monitoring system sensors, process information and other system resources"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/plasma-systemmonitor-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=5be0c214a4d48c85608169c0603c4d5687553c98bc1b45c7353be93f66cd8b12
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kdeclarative, kf6-kglobalaccel, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kirigami, kf6-kitemmodels, kf6-knewstuff, kf6-kquickcharts, kf6-kservice, kf6-kwindowsystem, kirigami-addons, ksystemstats, libc++, libksysguard, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
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
