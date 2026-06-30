CLANDRO_PKG_HOMEPAGE=https://fritzing.org/
CLANDRO_PKG_DESCRIPTION="An Electronic Design Automation software"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.6"
CLANDRO_PKG_REVISION=9
CLANDRO_PKG_SRCURL="https://github.com/fritzing/fritzing-app/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=eb4ebe461c5d42edb4b10f1f824e7c855ad54555e222c5999061dead09834491
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="fritzing-data, libc++, libgit2, qt5-qtbase, qt5-qtserialport, qt5-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers, qt5-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
PREFIX=$CLANDRO_PREFIX
PKG_CONFIG=pkg-config
"

clandro_step_configure() {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross" \
		${CLANDRO_PKG_EXTRA_CONFIGURE_ARGS}
}
