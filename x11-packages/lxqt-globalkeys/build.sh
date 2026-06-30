CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="Tools to set global keyboard shortcuts in LXQt sessions"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lxqt-globalkeys/releases/download/${CLANDRO_PKG_VERSION}/lxqt-globalkeys-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=6f7fb82337bd06823f698df5a1e631059e99e544bfa9a1d7c5b67fd01ff9319a
CLANDRO_PKG_DEPENDS="libc++, liblxqt, libx11, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
