CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/baloo"
CLANDRO_PKG_DESCRIPTION="A framework for searching and managing metadata"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.25.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/baloo-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d7746f5742d96f85c11b64a1aae8a6af1f20e55b815f81da8a4e6c3c5172a2d9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kfilemetadata, kf6-ki18n, kf6-kidletime, kf6-kio, kf6-solid, libc++, liblmdb, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
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
