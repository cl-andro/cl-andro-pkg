CLANDRO_PKG_HOMEPAGE=https://github.com/stoeckmann/xwallpaper
CLANDRO_PKG_DESCRIPTION="wallpaper setting utility for X"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.7.6"
CLANDRO_PKG_SRCURL=https://github.com/stoeckmann/xwallpaper/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=380aae8762a296f5e0284eff87ac92babd9c68e3e7612a8208f86b0dea814750
CLANDRO_PKG_DEPENDS="libjpeg-turbo, libpixman, libpng, libxcb, libxpm, xcb-util, xcb-util-image"

clandro_step_pre_configure() {
	autoreconf -fi
}
