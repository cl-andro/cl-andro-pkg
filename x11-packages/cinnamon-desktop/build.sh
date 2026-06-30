CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/cinnamon-desktop
CLANDRO_PKG_DESCRIPTION="The cinnamon-desktop library"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/cinnamon-desktop/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=4ed0d52a072551c6d536f1be68d4fcdb4166454fc9e48567ab2550282086b0f4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_DEPENDS="glib, gtk3, libcairo, libx11, libxext, xkeyboard-config, libxkbfile, gobject-introspection, libxrandr, iso-codes, pulseaudio, gdk-pixbuf, gigolo, cinnamon-menus"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dsystemd=disabled
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_meson
	clandro_setup_gir

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
