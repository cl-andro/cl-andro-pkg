CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/konsole/"
CLANDRO_PKG_DESCRIPTION="KDE terminal emulator"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/konsole-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=4c59dabc4b64201c61458e8997a66d1aa7dc98b181e5e85f3c0f5cb69066d963
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kbookmarks, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kguiaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-knewstuff, kf6-knotifications, kf6-knotifyconfig, kf6-kparts, kf6-kpty, kf6-kservice, kf6-ktextwidgets, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, libicu, qt6-qtbase, qt6-qtmultimedia"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_DBUS=ON
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
