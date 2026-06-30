CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/network/kio-extras"
CLANDRO_PKG_DESCRIPTION="Additional components to increase the functionality of KIO"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/kio-extras-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=f53a64fbe5f0bbcadde55f347fef41d2f39c0b5cdcb7c74df8dee7439ee1194c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash, kf6-karchive, kf6-kcmutils, kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-kdnssd, kf6-ki18n, kf6-kio, kf6-knotifications, kf6-kservice, kf6-kwidgetsaddons, kf6-syntax-highlighting, kf6-solid, libimobiledevice, libc++, libkexiv2, libproxy, libplist, libssh, libtirpc, libxcursor, perl, plasma-activities, qcoro, qt6-qt5compat, qt6-qtbase, qt6-qtimageformats, qt6-qtsvg, ripgrep-all"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules ,gperf, kf6-kdoctools, openexr, plasma-activities-stats, qcoro-static, taglib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_WITH_QT6=ON
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi

	LDFLAGS+=" -landroid-shmem"
}
