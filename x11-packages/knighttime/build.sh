CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/knighttime"
CLANDRO_PKG_DESCRIPTION="KDE Helper for scheduling the dark-light cycle"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/knighttime-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=96d43cedad1f1d4819a7c7418a4eb8ed26cc20b47a17ada865ffb0f25722ee7b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-kholidays, libc++, qt6-qtbase, qt6-qtpositioning"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-ki18n, qt6-qttools"
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
