CLANDRO_PKG_HOMEPAGE=https://github.com/zquestz/plank-reloaded
CLANDRO_PKG_DESCRIPTION="Fork of the original Plank project, providing a simple dock for X11 desktop environments"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.11.167"
CLANDRO_PKG_SRCURL="https://github.com/zquestz/plank-reloaded/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=7c24a46bff96eb86f1dfc820c843d78a14634077cbcbb3695b2cb1aad184c536
CLANDRO_PKG_DEPENDS="atk, bamf, libcairo, gdk-pixbuf, glib, gnome-menus, gtk3, libgee, libwnck, libx11, libxfixes, libxi, pango, libdbusmenu-gtk3"
CLANDRO_PKG_BUILD_DEPENDS="gnome-common, intltool, valac"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-apport=false
-Dproduction-release=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
