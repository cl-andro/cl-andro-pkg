CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/cinnamon-settings-daemon
CLANDRO_PKG_DESCRIPTION="The settings daemon for the Cinnamon desktop"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/cinnamon-settings-daemon/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=215006afe3e59e4998fd3bb9f8ecf1b7c926a08b5398b42e482c5008483c970a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_DEPENDS="glib, cinnamon-desktop, libcanberra, libcolord, fontconfig, libgnomekbd, gtk3, libnotify, pango, libxfixes, pulseaudio-glib, upower, libx11, libxklavier, littlecms"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddbus_service_dir="$CLANDRO_PREFIX/share/dbus-1/system-services/"
-Ddbus_system_dir="$CLANDRO_PREFIX/share/dbus-1/system.d/"
-Duse_polkit=disabled
-Duse_logind=disabled
-Duse_gudev=disabled
-Duse_cups=disabled
-Duse_smartcard=disabled
-Duse_wacom=disabled
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
