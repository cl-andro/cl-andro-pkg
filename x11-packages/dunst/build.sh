CLANDRO_PKG_HOMEPAGE=https://dunst-project.org/
CLANDRO_PKG_DESCRIPTION="Lightweight and customizable notification daemon"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.13.2"
CLANDRO_PKG_SRCURL="https://github.com/dunst-project/dunst/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=c68645cecef4a45840cd67c19a18a3a21ecae6b331e9864c2b745c31aee5fc85
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-wordexp, dbus, gdk-pixbuf, glib, harfbuzz, libcairo, libnotify, libx11, libxext, libxinerama, libxrandr, libxss, pango"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# TODO: Meson support is still considered experimental and may still have issues.
	mv meson.build{,.orig}

	LDFLAGS+=" -landroid-wordexp"
}
