CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/filelight/"
CLANDRO_PKG_DESCRIPTION="View disk usage information"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/filelight-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=4661cc46e4f89ccc6ac130c9c3be2eeed0598781a80ddda428c6dedcf49f8c03
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-ki18n, kf6-kio, kf6-kirigami, kf6-kwidgetsaddons, kf6-qqc2-desktop-style, kirigami-addons, libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTING=OFF
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
