CLANDRO_PKG_HOMEPAGE=https://github.com/wwmm/easyeffects
CLANDRO_PKG_DESCRIPTION="Audio effects for PulseAudio applications"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Do not upgrade to EasyEffects version.
CLANDRO_PKG_VERSION=4.8.7
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/wwmm/easyeffects/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d841f27df87b99747349be6b8de62d131422369908fcb57a81f39590437a8099
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="boost, glib, gst-plugins-bad, gst-plugins-base, gst-plugins-good, gstreamer, gtk3, gtkmm3, libbs2b, libc++, libebur128, librnnoise, libsndfile, libzita-convolver, lilv, pulseaudio"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, glib-cross, libsamplerate"

clandro_step_pre_configure() {
	case "$CLANDRO_PKG_VERSION" in
		4.*|*:4.* ) ;;
		* ) clandro_error_exit "Dubious version '$CLANDRO_PKG_VERSION' for package '$CLANDRO_PKG_NAME'." ;;
	esac

	export BOOST_ROOT=$CLANDRO_PREFIX
	clandro_setup_glib_cross_pkg_config_wrapper
}
