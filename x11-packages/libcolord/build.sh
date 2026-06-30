CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/software/colord
CLANDRO_PKG_DESCRIPTION="Client library of the daemon for managing color devices"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.7"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/hughsie/colord/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=09a2c35c2cf6afd28b9a107dd48090ee7a376c20008a7fd7b2eb576a46ee057e
CLANDRO_PKG_DEPENDS="glib, gobject-introspection, hwdata, libsqlite, littlecms"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dpnp_ids=$CLANDRO_PREFIX/share/hwdata/pnp.ids
-Dintrospection=true
-Ddaemon=false
-Dsystemd=false
-Dudev_rules=false
-Dargyllcms_sensor=false
-Dtests=false
-Dbash_completion=false
-Dman=false
-Ddocs=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libcolord.so.2
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
