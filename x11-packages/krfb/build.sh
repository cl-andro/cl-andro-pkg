CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/krfb/"
CLANDRO_PKG_DESCRIPTION="Desktop Sharing"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/krfb-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=591926a203a41546bf49239fc464f730b7ad1a4a3a5ae49204616d2b635ed1fe
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kdnssd, kf6-ki18n, kf6-knotifications, kf6-kstatusnotifieritem, kf6-kwallet, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, kpipewire, kwayland, libc++, libvncserver, libwayland, libx11, libxcb, libxtst, qt6-qtbase, xcb-util-image"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools, libxdamage, plasma-wayland-protocols"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi

	LDFLAGS+=" -landroid-shmem"
}
