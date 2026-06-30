CLANDRO_PKG_HOMEPAGE="https://flatpak.github.io/xdg-desktop-portal/"
CLANDRO_PKG_DESCRIPTION="Desktop integration portals for sandboxed apps"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.20.4"
CLANDRO_PKG_SRCURL="https://github.com/flatpak/xdg-desktop-portal/releases/download/${CLANDRO_PKG_VERSION}/xdg-desktop-portal-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=9528eb3b060b88ac82f294fbdc6af5f4d3adfa42575f2cd816cab3d3e0a7a68c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gst-plugins-base, gstreamer, json-glib, libc++, pipewire"
CLANDRO_PKG_BUILD_DEPENDS="docbook-xsl, geoclue, glib, glib-cross, gst-plugins-good, libportal, xmlto"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dsystemd=disabled
-Dsandboxed-image-validation=disabled
-Dsandboxed-sound-validation=disabled
-Ddocumentation=disabled
-Dtests=disabled
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
