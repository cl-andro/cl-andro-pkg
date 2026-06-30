CLANDRO_PKG_HOMEPAGE=https://github.com/directvt/vtm
CLANDRO_PKG_DESCRIPTION="Terminal multiplexer with TUI window manager and multi-party session sharing"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2026.05.08"
CLANDRO_PKG_SRCURL="https://github.com/directvt/vtm/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=c782c446e872920c985a4c99b2a1ce3847dc77fe273349e0dea0bb954c275ee8
CLANDRO_PKG_DEPENDS="freetype, harfbuzz, libc++, lua54, lunasvg"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-spawn, stb"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DSTB_INCLUDE_DIR=$CLANDRO__PREFIX__INCLUDE_DIR/stb"

clandro_step_pre_configure() {
	CXXFLAGS+=" -pthread"
}
