CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/totem-pl-parser
CLANDRO_PKG_DESCRIPTION="Simple GObject-based library to parse and save a host of playlist formats"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.26.7"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/totem-pl-parser/${CLANDRO_PKG_VERSION%.*}/totem-pl-parser-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=60d517c1acabe54ae337f64451264fc76730696eaae26b5480fb37166689b5f3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libarchive, libgcrypt, libxml2"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-gtk-doc=false
-Denable-libarchive=yes
-Denable-libgcrypt=yes
-Dintrospection=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	# Fix linker script error
	LDFLAGS+=" -Wl,--undefined-version"
}
