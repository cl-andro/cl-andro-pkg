CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/libxfce4windowing/start
CLANDRO_PKG_DESCRIPTION="Windowing concept abstraction library for X11 and Wayland"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.5"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/libxfce4windowing/${CLANDRO_PKG_VERSION%.*}/libxfce4windowing-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=6b4e19a66db650c9c8a88f00bbf266e9ced0070b7dbc0aaeea05be0fc6a2eb4d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libdisplay-info, libwayland, libwnck, libx11, libxrandr, pango, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, libwayland-protocols, libwayland-cross-scanner, xfce4-dev-tools"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--disable-static
--enable-introspection=yes
--enable-gtk-doc-html=no
--enable-wayland
--enable-x11
XDT_GEN_VISIBILITY=${CLANDRO_PREFIX}/bin/xdt-gen-visibility
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_wayland_cross_pkg_config_wrapper
}
