CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="PCManFM-Qt is the file manager of LXQt"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/pcmanfm-qt/releases/download/${CLANDRO_PKG_VERSION}/pcmanfm-qt-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=53fb1acf5a818300487ceffabc5b768034fa4dee956b9d1bc0019bb456b48daf
CLANDRO_PKG_DEPENDS="desktop-file-utils, glib, layer-shell-qt, libc++, libfm-qt, libxcb, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
