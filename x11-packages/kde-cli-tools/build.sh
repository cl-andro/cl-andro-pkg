CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kde-cli-tools"
CLANDRO_PKG_DESCRIPTION="Tools based on KDE Frameworks to better interact with the system"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kde-cli-tools-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=0d7cdd7875a970768f0a173748d6e301157adcac2ec7b6b6233f792277497704
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash, kf6-kcmutils, kf6-kcompletion, kf6-kconfig, kf6-kcoreaddons, kf6-ki18n, kf6-kio, kf6-kparts, kf6-kservice, kf6-kwidgetsaddons, kf6-kwindowsystem, libc++, qt6-qtbase, qt6-qtsvg"
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
