CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GtkSourceView
CLANDRO_PKG_DESCRIPTION="A GNOME library that extends GtkTextView"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.24.11
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gtksourceview/${CLANDRO_PKG_VERSION%.*}/gtksourceview-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=691b074a37b2a307f7f48edc5b8c7afa7301709be56378ccf9cc9735909077fd
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libxml2, pango, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
--enable-vala=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libgtksourceview-3.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
