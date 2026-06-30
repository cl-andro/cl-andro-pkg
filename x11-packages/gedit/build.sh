CLANDRO_PKG_HOMEPAGE=https://gedit-technology.github.io/apps/gedit/
CLANDRO_PKG_DESCRIPTION="GNOME Text Editor"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.0"
# for submodules https://gitlab.gnome.org/World/gedit/gedit/-/issues/611
CLANDRO_PKG_SRCURL="git+https://gitlab.gnome.org/World/gedit/gedit"
CLANDRO_PKG_GIT_BRANCH="${CLANDRO_PKG_VERSION}"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gobject-introspection, gsettings-desktop-schemas, gspell, gtk3, libcairo, libgedit-amtk, libgedit-gfls, libgedit-gtksourceview, libgedit-tepl, libpeas, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_RECOMMENDS="gedit-help"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtk_doc=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
