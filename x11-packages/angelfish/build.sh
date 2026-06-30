CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/angelfish"
CLANDRO_PKG_DESCRIPTION="Web browser for Plasma Mobile"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/angelfish-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=1dfd5bb6816b749bd0ad21aa3a53f870abe29646c56d6921b0f811098e8a5aa9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="futuresql, kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-ki18n, kf6-kirigami, kf6-knotifications, kf6-kwindowsystem, kf6-purpose, kf6-qqc2-desktop-style, kirigami-addons, libc++, qcoro, qt6-qt5compat, qt6-qtbase, qt6-qtdeclarative, qt6-qtwebengine"
CLANDRO_PKG_BUILD_DEPENDS="corrosion, extra-cmake-modules, qcoro-static"
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DCMAKE_MODULE_PATH=$CLANDRO_PREFIX/share/cmake
"

clandro_step_pre_configure() {
	clandro_setup_rust

	[[ "${CLANDRO_ARCH}" == "arm" ]] && CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_ANDROID_ARM_MODE=ON"

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DRust_CARGO_TARGET=$CARGO_TARGET_NAME"

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake"
	fi
}
