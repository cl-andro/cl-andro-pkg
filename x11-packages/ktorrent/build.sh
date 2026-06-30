CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/network/ktorrent"
CLANDRO_PKG_DESCRIPTION="A powerful BitTorrent client for KDE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/ktorrent-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d168629b80c786a5a7d9c284039844c5e2cb7086d8fd9aa37a81f64546ec6883
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-karchive, kf6-kcmutils, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kglobalaccel, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-knotifications, kf6-knotifyconfig, kf6-kparts, kf6-kstatusnotifieritem, kf6-ktextwidgets, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, libc++, libktorrent, libmaxminddb, phonon-qt6, qt6-qt5compat, qt6-qtbase, qt6-qtwebengine"
CLANDRO_PKG_BUILD_DEPENDS="boost, extra-cmake-modules, kf6-kdnssd, kf6-kdoctools, kf6-kplotting, kf6-syndication, taglib"
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
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
