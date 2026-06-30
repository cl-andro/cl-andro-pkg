CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GdkPixbuf
CLANDRO_PKG_DESCRIPTION="Library for image loading and manipulation"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.44.6"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gdk-pixbuf/${CLANDRO_PKG_VERSION%.*}/gdk-pixbuf-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=140c2d0b899fcf853ee92b26373c9dc228dbcde0820a4246693f4328a27466fa
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libpng, libtiff, libjpeg-turbo, zstd"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_BREAKS="gdk-pixbuf-dev"
CLANDRO_PKG_REPLACES="gdk-pixbuf-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dandroid=disabled
-Dgtk_doc=false
-Dintrospection=enabled
-Dgio_sniffing=false
-Dothers=enabled
-Dtests=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libgdk_pixbuf-2.0.so.0"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		[ -e "${f}" ] || clandro_error_exit "SOVERSION guard check failed."
	done
}

clandro_step_create_debscripts() {
	for i in $(test "$CLANDRO_PACKAGE_FORMAT" != "pacman" && echo postinst) prerm triggers; do
		sed \
			"s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
			"${CLANDRO_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	chmod 644 ./triggers
}
