CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/krdc/"
CLANDRO_PKG_DESCRIPTION="Remote Desktop Client by KDE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/krdc-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=212b2c2aaa71c1d29f4356ae64785ccca600a565cfe0e03349afcb95d1444a98
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="keditbookmarks, kf6-kbookmarks, kf6-kcmutils, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdnssd, kf6-kguiaddons, kf6-ki18n, kf6-kio, kf6-knotifyconfig, kf6-kstatusnotifieritem, kf6-kwidgetsaddons, kf6-kxmlgui, libc++, libssh, libwayland, qt6-qtbase, qtkeychain"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, freerdp, kf6-kdoctools, libvncserver"
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
