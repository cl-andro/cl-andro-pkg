CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="Tools to configure LXQt and the underlying operating system"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lxqt-config/releases/download/${CLANDRO_PKG_VERSION}/lxqt-config-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=8943a0d61993e068fa71aac85eb1eb93ac32064928ee1c8c1ff9666b45e1610e
CLANDRO_PKG_DEPENDS="libc++, liblxqt, libqtxdg, libxcb, libxcursor, libxfixes, lxqt-menu-data, qt6-qtbase, shared-mime-info, zlib"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
# libinput is required to switch on input configuration
# libkscreen is required to switch on monitor configuration, which in turn requires wayland
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_INPUT=OFF
-DWITH_MONITOR=OFF
"

CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi

	# This is required because of the private lib used by lxqt-config-appearance
	LDFLAGS+=" -Wl,-rpath=${CLANDRO_PREFIX}/lib/lxqt-config"
	export LDFLAGS
}
