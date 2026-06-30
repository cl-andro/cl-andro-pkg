CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="A simple & lightweight Qt file archiver"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lxqt-archiver/releases/download/${CLANDRO_PKG_VERSION}/lxqt-archiver-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=b93eda6d80391d373a47afd8b28fa401762300dcdb51d8bc1d3a2263bc186ae7
CLANDRO_PKG_DEPENDS="glib, json-glib, libc++, libfm-qt, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
