CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gnome-screenshot
CLANDRO_PKG_DESCRIPTION="GNOME Screenshot utility"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="41.0"
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/gnome-screenshot/${CLANDRO_PKG_VERSION%%.*}/gnome-screenshot-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=4adb7dec926428f74263d5796673cf142e4720b6e768f5468a8d0933f98c9597
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk3, libx11, libxext, libhandy"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dx11=enabled
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
