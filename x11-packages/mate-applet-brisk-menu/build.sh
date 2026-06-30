CLANDRO_PKG_HOMEPAGE=https://github.com/solus-project/brisk-menu
CLANDRO_PKG_DESCRIPTION="An efficient menu for the MATE Desktop"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_VERSION=0.6.2
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_SRCURL=http://deb.debian.org/debian/pool/main/b/brisk-menu/brisk-menu_${CLANDRO_PKG_VERSION}.orig.tar.xz
CLANDRO_PKG_SHA256=5a87f4dcf7365e81a571128bf0b8199eb06a6fcd7e15ec7739be0ccff1326488
CLANDRO_PKG_DEPENDS="dconf, glib, gtk3, libnotify, libx11, mate-menus, mate-panel"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
