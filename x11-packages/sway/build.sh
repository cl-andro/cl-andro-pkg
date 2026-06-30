CLANDRO_PKG_HOMEPAGE=https://github.com/swaywm/sway
CLANDRO_PKG_DESCRIPTION="i3-compatible Wayland compositor"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.10.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/swaywm/sway/releases/download/$CLANDRO_PKG_VERSION/sway-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=b2fbf3a2f94c8926efa18d6af59bb9f5f1eafa6d46491284b1610c57bef2d105
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, json-c, libandroid-wordexp, libcairo, libevdev, libwayland, pango, pcre2, wlroots (>= 0.18.1)"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-protocols, libwayland-cross-scanner, scdoc"
CLANDRO_PKG_RECOMMENDS="xwayland"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dman-pages=enabled
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper

	# XXX: use alloca for shm_open
	export CPPFLAGS+=" -Wno-alloca"
	export LDFLAGS+=" -landroid-wordexp"
}
