CLANDRO_PKG_HOMEPAGE=https://www.gtk.org/
CLANDRO_PKG_DESCRIPTION="GObject-based multi-platform GUI toolkit"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.22.4"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gtk/${CLANDRO_PKG_VERSION%.*}/gtk-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=51bd9f60c7d23a665a556c7364c21fb2e4e282566b3e7e092455e8f910330893
CLANDRO_PKG_DEPENDS="adwaita-icon-theme, fontconfig, fribidi, gdk-pixbuf, glib, graphene, gtk-update-icon-cache, harfbuzz, iso-codes, libcairo, libdrm, libepoxy, libjpeg-turbo, libpng, librsvg, libtiff, libwayland, libx11, libxcursor, libxdamage, libxext, libxfixes, libxi, libxinerama, libxkbcommon, libxrandr, pango, shared-mime-info"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, libwayland-protocols, libwayland-cross-scanner, xorgproto"
CLANDRO_PKG_RECOMMENDS="desktop-file-utils, librsvg, ttf-dejavu"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
# Prevent updating to unstable branch
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-demos=true
-Dbuild-examples=false
-Dbuild-tests=false
-Dbuild-testsuite=false
-Dintrospection=enabled
-Dmedia-gstreamer=disabled
-Dprint-cups=disabled
-Dvulkan=disabled
-Dwayland-backend=true
-Dx11-backend=true
-Dwayland-backend=true
"

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_gir
	clandro_setup_ninja
	clandro_setup_pkg_config_wrapper "${CLANDRO_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig:${CLANDRO_PREFIX}/opt/libwayland/cross/lib/x86_64-linux-gnu/pkgconfig"
}
