CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="A terminal emulator widget for Qt 5"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/qtermwidget/releases/download/${CLANDRO_PKG_VERSION}/qtermwidget-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=ceb7d1991ecc0e75b751b6b7786c4962598d367c6e9a0b55f78fc12a49f25304
CLANDRO_PKG_DEPENDS="libc++, libx11, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
