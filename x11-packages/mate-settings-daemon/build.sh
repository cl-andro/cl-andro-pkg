CLANDRO_PKG_HOMEPAGE=https://mate-settings-daemon.mate-desktop.dev/
CLANDRO_PKG_DESCRIPTION="mate-settings-daemon is a fork of gnome-settings-daemon"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-settings-daemon/releases/download/v$CLANDRO_PKG_VERSION/mate-settings-daemon-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=4ed7cdadaaa4c99efffc0282b8411703bb76e072c41c4b57989f8c5b40611a3a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, dbus, dbus-glib, dconf, fontconfig, freetype, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libcanberra, libice, libmatekbd, libmatemixer, libnotify, libsm, libx11, libxext, libxi, libxklavier, mate-desktop, pango, startup-notification, zlib"

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
}
