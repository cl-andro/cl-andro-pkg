CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="LXQt Image Viewer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lximage-qt/releases/download/${CLANDRO_PKG_VERSION}/lximage-qt-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=7ca49039f3246011b80d76037603ac6a7af484574d8e5e2cc5bb7b8534298636
CLANDRO_PKG_DEPENDS="glib, libc++, libexif, libfm-qt, libx11, libxfixes, qt6-qtbase, qt6-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
