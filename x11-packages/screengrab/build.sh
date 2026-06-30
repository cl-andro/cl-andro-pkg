CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="Cross-platform tool for creating screenshots"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.2.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/screengrab/releases/download/${CLANDRO_PKG_VERSION}/screengrab-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=f43f27b261c3b22f05c79cb0131460bb144faf2720b590fc906c89cbcd3678bf
CLANDRO_PKG_DEPENDS="kf6-kwindowsystem, layer-shell-qt, libc++, libx11, libxcb, libqtxdg, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
