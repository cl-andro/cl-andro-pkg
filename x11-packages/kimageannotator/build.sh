CLANDRO_PKG_HOMEPAGE=https://github.com/ksnip/kImageAnnotator
CLANDRO_PKG_DESCRIPTION="Tool for annotating images"
CLANDRO_PKG_LICENSE="LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.7.2"
CLANDRO_PKG_SRCURL="https://github.com/ksnip/kImageAnnotator/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=7eb593d975b1590a184354ef68dbc3c26479d58eaea00de461d73695176f623c
CLANDRO_PKG_DEPENDS="libc++, kcolorpicker, libx11, qt6-qtbase, qt6-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qttools, qt6-qttools-cross-tools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_SHARED_LIBS=ON
-DBUILD_WITH_QT6=ON
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
