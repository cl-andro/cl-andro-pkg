CLANDRO_PKG_HOMEPAGE=https://mutter.gnome.org/
CLANDRO_PKG_DESCRIPTION="A Wayland display server and X11 window manager and compositor library"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="48.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/mutter/${CLANDRO_PKG_VERSION%%.*}/mutter-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=e9970b3d81c76aed1e91f3436a82e7b14c5e32cf55949b1c9a18d0f157bacafc
CLANDRO_PKG_DEPENDS="atk, fribidi, gdk-pixbuf, glib, gnome-desktop4, gobject-introspection, graphene, gsettings-desktop-schemas, gtk4, harfbuzz, libandroid-shmem, libcairo, libcanberra, libcolord, libdisplay-info, libdrm, libei, libice, libpixman, libsm, libwayland, libx11, libxau, libxcb, libxcomposite, libxcursor, libxdamage, libxext, libxfixes, libxi, libxinerama, libxkbcommon, libxkbfile, libxrandr, libxtst, littlecms, opengl, pango, pipewire, startup-notification, xkeyboard-config, xwayland"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross, libwayland-protocols"
CLANDRO_PKG_VERSIONED_GIR=false

# TODO: Add libwacom
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dlogind=false
-Dudev=false
-Dnative_backend=false
-Dlibwacom=false
-Dintrospection=true
-Dtests=disabled
-Dinstalled_tests=false
-Dbash_completion=false
-Dprofiler=false
-Dxwayland_path=$CLANDRO_PREFIX/bin/Xwayland
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
	LDFLAGS+=" -landroid-shmem"
}
