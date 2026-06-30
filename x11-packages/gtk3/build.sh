CLANDRO_PKG_HOMEPAGE=https://www.gtk.org/
CLANDRO_PKG_DESCRIPTION="GObject-based multi-platform GUI toolkit"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.24.52"
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/gtk/-/archive/$CLANDRO_PKG_VERSION/gtk-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e62514019679f831fcb37f3d294a761c3a6c14f1d346745ad11d70c2be17146e
CLANDRO_PKG_DEPENDS="adwaita-icon-theme, at-spi2-core, coreutils, desktop-file-utils, fontconfig, fribidi, gdk-pixbuf, glib, gtk-update-icon-cache, harfbuzz, libcairo, libepoxy, libwayland, libxcomposite, libxcursor, libxdamage, libxfixes, libxi, libxinerama, libxkbcommon, libxrandr, pango, shared-mime-info, ttf-dejavu"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, libwayland-protocols, libwayland-cross-scanner, xorgproto"
CLANDRO_PKG_CONFLICTS="libgtk3"
CLANDRO_PKG_REPLACES="libgtk3"
# Prevent updating to unstable branch or gtk4
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbroadway_backend=true
-Dexamples=false
-Dintrospection=true
-Dman=true
-Dprint_backends=file,lpr
-Dtests=false
-Dwayland_backend=true
-Dx11_backend=true
-Dxinerama=yes
"

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_gir
	clandro_setup_ninja
	clandro_setup_pkg_config_wrapper "${CLANDRO_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig:${CLANDRO_PREFIX}/opt/libwayland/cross/lib/x86_64-linux-gnu/pkgconfig"

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES=(
		'lib/libgailutil-3.so.0'
		'lib/libgdk-3.so.0'
		'lib/libgtk-3.so.0'
	)

	local f
	for f in "${_SOVERSION_GUARD_FILES[@]}"; do
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
