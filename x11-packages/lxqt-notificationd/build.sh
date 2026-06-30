CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="The LXQt notification daemon"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lxqt-notificationd/releases/download/${CLANDRO_PKG_VERSION}/lxqt-notificationd-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=525a21feb622cb255f10b7ebd28b4af5afba9da4833560337f167ffe5f1d19d2
CLANDRO_PKG_DEPENDS="kf6-kwindowsystem, layer-shell-qt, libc++, liblxqt, libqtxdg, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
