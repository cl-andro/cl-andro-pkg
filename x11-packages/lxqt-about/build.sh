CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="LXQt dialog showing information about LXQt and the system"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lxqt-about/releases/download/${CLANDRO_PKG_VERSION}/lxqt-about-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=77263dd1b3582791b7134c590a2aee641fb7423ee5f89cf05378529276445fae
CLANDRO_PKG_DEPENDS="libc++, liblxqt, libqtxdg, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
