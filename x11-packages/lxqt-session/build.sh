CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="The LXQt session manager"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lxqt-session/releases/download/${CLANDRO_PKG_VERSION}/lxqt-session-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d77f378ece0bfc7195f1964e88f55919729c3b0a55a858d7155ffaacc57bba44
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kwindowsystem, layer-shell-qt, libandroid-wordexp, libc++, liblxqt, libqtxdg, libx11, procps, qt6-qtbase, qtxdg-tools"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_LIBUDEV=OFF
"

clandro_step_pre_configure(){
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi

	LDFLAGS+=" -landroid-wordexp"
}
