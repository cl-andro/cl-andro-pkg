CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/education/kig"
CLANDRO_PKG_DESCRIPTION="Interactive Geometry"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/kig-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=0850e5488ff7c7120fed475681eca7cc0d0b90d8869523f4ec88e370e5149436
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="boost, kf6-karchive, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-ki18n, kf6-kiconthemes, kf6-kparts, kf6-ktexteditor, kf6-kwidgetsaddons, kf6-kxmlgui, libc++, python, qt6-qtbase, qt6-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, extra-cmake-modules, kf6-kdoctools"
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
