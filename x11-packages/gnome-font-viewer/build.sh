CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gnome-font-viewer
CLANDRO_PKG_DESCRIPTION="A font viewer utility for GNOME"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.0"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gnome-font-viewer/${CLANDRO_PKG_VERSION%.*}/gnome-font-viewer-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=9564b088c5b150c54e2a3a7bc7014deec6ee551261e98488f891b1f1b8dc6b80
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, fribidi, glib, graphene, gtk4, harfbuzz, libadwaita, libcairo, pango"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
