CLANDRO_PKG_HOMEPAGE=https://gitlab.freedesktop.org/wlroots/wlroots
CLANDRO_PKG_DESCRIPTION="Modular wayland compositor library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.18.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/wlroots/wlroots/-/archive/${CLANDRO_PKG_VERSION}/wlroots-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=a28061f7778f28f7be377fd4d6f0ebd58cb2a63b52460e9fde28e2ab43e80cab
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libdrm, libglvnd, libpixman, libwayland, libxcb, libxkbcommon, xcb-util-renderutil, xcb-util-wm, clandro-gui-c"
CLANDRO_PKG_BUILD_DEPENDS="libglvnd-dev, libwayland-cross-scanner, libwayland-protocols, xwayland"
CLANDRO_PKG_RECOMMENDS="xwayland"
CLANDRO_PKG_BREAKS="sway (<< 1.10 )"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dexamples=false
-Dxwayland=enabled
-Dsession=disabled
-Dbackends=x11,termuxgui
-Drenderers=gles2,vulkan
"

clandro_step_post_get_source() {
	cp -r $CLANDRO_PKG_BUILDER_DIR/src/* $CLANDRO_PKG_SRCDIR/
}

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper

	# XXX: use alloca for shm_open
	export CPPFLAGS+=" -Wno-alloca -Wno-strict-prototypes"
}
