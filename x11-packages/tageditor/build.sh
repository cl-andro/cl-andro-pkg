CLANDRO_PKG_HOMEPAGE=https://github.com/Martchus/tageditor
CLANDRO_PKG_DESCRIPTION="A tag editor with Qt GUI and command-line interface. Supports MP4 (iTunes), ID3, Vorbis, Opus, FLAC and Matroska"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.9.9"
CLANDRO_PKG_SRCURL=https://github.com/Martchus/tageditor/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f8b7347c3c54a5b2234c7b5233888face32a3d4220baab415a37af55583714e9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libc++utilities, qt6-qtbase, qt6-qtdeclarative, qtutilities, tagparser"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qtdeclarative-cross-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWEBVIEW_PROVIDER=none
-DQT_PACKAGE_PREFIX=Qt6
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}
