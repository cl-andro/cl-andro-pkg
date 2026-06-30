CLANDRO_PKG_HOMEPAGE=https://polybar.github.io
CLANDRO_PKG_DESCRIPTION="A fast and easy-to-use status bar"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.7.2"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/polybar/polybar/releases/download/${CLANDRO_PKG_VERSION}/polybar-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=e2feacbd02e7c94baed7f50b13bcbf307d95df0325c3ecae443289ba5b56af29
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, jsoncpp, libandroid-glob, libc++, libcairo, libcurl, libnl, libuv, libxcb, pulseaudio, xcb-util-cursor, xcb-util-image, xcb-util-wm, xcb-util-xrm"
CLANDRO_PKG_BUILD_DEPENDS="i3"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DENABLE_I3=ON"
CLANDRO_PKG_CONFFILES="etc/polybar/config.ini"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"

	# ld.lld: error: undefined symbol: Json::Value::operator[](char const*)
	CXXFLAGS+=" -DJSONCPP_HAS_STRING_VIEW=1"
}
