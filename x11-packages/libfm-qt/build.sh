CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="Library providing components to build desktop file managers"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/libfm-qt/releases/download/${CLANDRO_PKG_VERSION}/libfm-qt-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=72766d7b41fd1aa06c0a7ef8be015205506ff75963b977e5307994555dcc023b
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, glib, libxcb, libexif, lxqt-menu-data, menu-cache"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
