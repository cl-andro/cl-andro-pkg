CLANDRO_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="GStreamer Bad Plug-ins"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.2"
CLANDRO_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6467e3964828f4d7d08bfe1fbb4d76287a1c8fa76674e59e101a149c020fefd7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="game-music-emu, glib, gst-plugins-base, gstreamer, libaom, libass, libbz2, libcairo, libcurl, libopus, librsvg, libsndfile, libsrt, libx11, libxml2, littlecms, openal-soft, openh264, openjpeg, openssl, pango"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_BREAKS="gst-plugins-bad-dev"
CLANDRO_PKG_REPLACES="gst-plugins-bad-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dandroidmedia=disabled
-Dexamples=disabled
-Drtmp=disabled
-Dshm=disabled
-Dtests=disabled
-Dzbar=disabled
-Dwebp=disabled
-Dvulkan=disabled
-Dhls-crypto=openssl
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
