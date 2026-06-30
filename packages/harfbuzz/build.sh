CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/HarfBuzz/
CLANDRO_PKG_DESCRIPTION="OpenType text shaping engine"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="14.2.0"
CLANDRO_PKG_SRCURL=https://github.com/harfbuzz/harfbuzz/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c652d5d94971031654ab3989891a490a895d3e3f2b71171c62692b28e94b1b93
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, glib, libcairo, libgraphite"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_BREAKS="harfbuzz-dev"
CLANDRO_PKG_REPLACES="harfbuzz-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dcpp_std=c++17
-Ddocs=disabled
-Dgobject=enabled
-Dgraphite=enabled
-Dintrospection=enabled
-Dtests=disabled
"
CLANDRO_PKG_RM_AFTER_INSTALL="
share/gtk-doc
"

clandro_step_post_get_source() {
	mv CMakeLists.txt CMakeLists.txt.unused

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local e=$(grep -oP "hb_so_version = '\K\d+" src/meson.build | uniq)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "${e}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_make_install() {
	install -Dm600 "$CLANDRO_PKG_BUILDER_DIR"/hb-info.1 "$CLANDRO_PREFIX"/share/man/man1/hb-info.1
	install -Dm600 "$CLANDRO_PKG_BUILDER_DIR"/hb-shape.1 "$CLANDRO_PREFIX"/share/man/man1/hb-shape.1
	install -Dm600 "$CLANDRO_PKG_BUILDER_DIR"/hb-subset.1 "$CLANDRO_PREFIX"/share/man/man1/hb-subset.1
	install -Dm600 "$CLANDRO_PKG_BUILDER_DIR"/hb-vector.1 "$CLANDRO_PREFIX"/share/man/man1/hb-vector.1
	install -Dm600 "$CLANDRO_PKG_BUILDER_DIR"/hb-view.1 "$CLANDRO_PREFIX"/share/man/man1/hb-view.1
}
