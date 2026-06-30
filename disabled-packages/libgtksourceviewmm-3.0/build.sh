CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GtkSourceView
CLANDRO_PKG_DESCRIPTION="C++ binding for gtksourceview"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=3.21
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.3
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gtksourceviewmm/${_MAJOR_VERSION}/gtksourceviewmm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=dbb00b1c28e0407cc27d8b07a2ed0b4ea22f92e4b3e3006431cbd6726b6256b5
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, gtkmm3, gtksourceview3, harfbuzz, libatkmm-1.6, libc++, libcairo, libcairomm-1.0, libglibmm-2.4, libpangomm-1.4, libsigc++-2.0, pango, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-documentation
"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
