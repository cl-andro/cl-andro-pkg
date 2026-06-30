CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="A lightweight Qt terminal emulator"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/qterminal/releases/download/${CLANDRO_PKG_VERSION}/qterminal-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=aeb6cf5ff7f31f0b89e60f6cc1c83c4d6fbed57717196d2ebba2bc0dcb8436d4
CLANDRO_PKG_DEPENDS="layer-shell-qt, libc++, libx11, qt6-qtbase, qtermwidget"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
