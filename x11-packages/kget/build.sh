CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/kget/"
CLANDRO_PKG_DESCRIPTION="Download Manager by KDE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/kget-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=a2b5a6ac9ead7beea32183b1f9ddb74ef59204b0daf1f78ff50b7dc3f9e4e36d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gpgmepp, kf6-kcmutils, kf6-kcolorscheme, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kitemviews, kf6-knotifications, kf6-knotifyconfig, kf6-kstatusnotifieritem, kf6-kwallet, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, libc++, qgpgme, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="boost, extra-cmake-modules, kf6-kdoctools, libktorrent"
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
