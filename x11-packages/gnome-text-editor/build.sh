CLANDRO_PKG_HOMEPAGE=https://apps.gnome.org/TextEditor/
CLANDRO_PKG_DESCRIPTION="GNOME Text Editor is a simple text editor focused on a pleasing default experience"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.0"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gnome-text-editor/${CLANDRO_PKG_VERSION%.*}/gnome-text-editor-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=9dc299da4daa085423b5d48db59f0021ad55e74143a5cb8ab2e5ffe17967f45b
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="editorconfig-core-c, glib, gtk4, gtksourceview5, libadwaita, libandroid-wordexp, libcairo, libspelling, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_RECOMMENDS="gnome-text-editor-help"

clandro_step_pre_configure() {
	# Workaround strict compiler error
	sed -i "s/-Werror/-Wno-error/g" meson.build

	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export LDFLAGS+=" -landroid-wordexp"
}
