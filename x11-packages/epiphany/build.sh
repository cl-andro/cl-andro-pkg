CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/Web
CLANDRO_PKG_DESCRIPTION="A GNOME web browser based on the WebKit rendering engine"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.4"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/epiphany/${CLANDRO_PKG_VERSION%%.*}/epiphany-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1e26f9901f0f08bfe943aa70163c953334c7ec3d4aefc8d354e8a9c140b334a7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="adwaita-icon-theme, gcr4, gdk-pixbuf, glib, graphene, gsettings-desktop-schemas, gstreamer, gtk4, iso-codes, json-glib, libadwaita, libarchive, libcairo, libgmp, libnettle, libportal-gtk4, libsecret, libsoup3, libsqlite, libxml2, pango, webkitgtk-6.0"
CLANDRO_PKG_BUILD_DEPENDS="blueprint-compiler, glib-cross"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dunit_tests=disabled
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_bpc
}
