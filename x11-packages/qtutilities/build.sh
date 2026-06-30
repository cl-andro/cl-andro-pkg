CLANDRO_PKG_HOMEPAGE=https://github.com/Martchus/qtutilities
CLANDRO_PKG_DESCRIPTION="Common Qt related C++ classes and routines used by my applications such as dialogs, widgets and models"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.21.0"
CLANDRO_PKG_SRCURL=https://github.com/Martchus/qtutilities/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e50a9d0335f025e67a13e059d3625c5bea8988c647ad5f7f1da53530682af70d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libc++utilities, libx11, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DQT_PACKAGE_PREFIX=Qt6
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
