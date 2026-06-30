CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/muffin
CLANDRO_PKG_DESCRIPTION="The window management library for the Cinnamon desktop"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/muffin/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=af1aa8e68699895a841415c007c7f3f48efc06f07c50d219d30f8131a981248e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_DEPENDS="atk, fribidi, gdk-pixbuf, glib, gnome-desktop4, gobject-introspection, graphene, gsettings-desktop-schemas, gtk4, harfbuzz, libandroid-shmem, libcairo, libcanberra, libcolord, libdisplay-info, libdrm, libei, libice, libpixman, libsm, libwayland, libx11, libxau, libxcb, libxcomposite, libxcursor, libxdamage, libxext, libxfixes, libxi, libxinerama, libxkbcommon, libxkbfile, libxrandr, libxtst, littlecms, opengl, pango, pipewire, startup-notification, xkeyboard-config, xwayland, upower, cinnamon-desktop, json-glib, cogl, clutter, clutter-gtk"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross, libwayland-protocols"
CLANDRO_PKG_VERSIONED_GIR=false

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dudev=false
-Dnative_backend=false
-Dremote_desktop=false
-Dlibwacom=false
-Dintrospection=true
-Dtests=false
-Dcore_tests=false
-Dinstalled_tests=false
-Dprofiler=false
-Dxwayland_path=$CLANDRO_PREFIX/bin/Xwayland
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
	LDFLAGS+=" -landroid-shmem"
}
