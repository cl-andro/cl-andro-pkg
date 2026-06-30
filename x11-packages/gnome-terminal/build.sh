CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/Terminal
CLANDRO_PKG_DESCRIPTION="Terminal emulator for GNOME"
CLANDRO_PKG_LICENSE="GPL-3.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.60.0"
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/gnome-terminal/${CLANDRO_PKG_VERSION%.*}/gnome-terminal-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=b8daf3f08545172c4d2885733f720361ab0349ea669b99245eed4ad16ed3de28
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk3, libx11, dbus, gsettings-desktop-schemas, libhandy, libvte "
CLANDRO_PKG_BUILD_DEPENDS="glib-cross, dconf, pcre2, gettext, libxslt"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=false
-Ddbg=false
-Dnautilus_extension=false
-Dsearch_provider=false
"

clandro_step_post_get_source() {
	rm -f subprojects/*.wrap
}

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_make_install() {
	install -Dm644 "$CLANDRO_PKG_BUILDER_DIR/org.gnome.Terminal.gschema.override" "$CLANDRO_PREFIX/share/glib-2.0/schemas/org.gnome.Terminal.gschema.override"
}
