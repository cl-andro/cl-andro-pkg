CLANDRO_PKG_HOMEPAGE=https://freedesktop.org/software/pulseaudio/pavucontrol/
CLANDRO_PKG_DESCRIPTION="PulseAudio Volume Control"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.2"
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/pulseaudio/pavucontrol/-/archive/v$CLANDRO_PKG_VERSION/pavucontrol-v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e3677926f1eec42e24dd14ac5208e8ad557a807c3c18b1cd6c5faea531e840de
CLANDRO_PKG_DEPENDS="glib, gtk4, gtkmm4, json-glib, libcanberra, libsigc++-3.0, pulseaudio, pulseaudio-glib"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
