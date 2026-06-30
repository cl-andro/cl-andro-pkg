CLANDRO_PKG_HOMEPAGE=https://github.com/tsujan/Kvantum
CLANDRO_PKG_DESCRIPTION="SVG-based theme engine for Qt6"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.6"
CLANDRO_PKG_SRCURL="https://github.com/tsujan/Kvantum/releases/download/V${CLANDRO_PKG_VERSION}/Kvantum-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=018df6bf93924c5af55c927998f096f8c70845a2f6031f5e0fcc95edb336674b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="kf6-kwindowsystem, libc++, libx11, qt6-qtbase, qt6-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qttools-cross-tools"

clandro_step_post_get_source() {
	CLANDRO_PKG_SRCDIR+="/Kvantum"
}

clandro_step_post_make_install() {
	local _QT6_STYLES_DIR=$CLANDRO_PREFIX/lib/qt6/plugins/styles
	mkdir -p "$_QT6_STYLES_DIR"
	mv $CLANDRO_PREFIX/opt/qt6/cross/lib/qt6/plugins/styles/libkvantum.so $_QT6_STYLES_DIR
}
