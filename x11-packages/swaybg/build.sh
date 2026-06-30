CLANDRO_PKG_HOMEPAGE=https://github.com/swaywm/swaybg
CLANDRO_PKG_DESCRIPTION="Wallpaper tool for Wayland compositors"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.2"
CLANDRO_PKG_SRCURL=https://github.com/swaywm/swaybg/releases/download/v${CLANDRO_PKG_VERSION}/swaybg-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a6652a0060a0bea3c3318d9d03b6dddac34f6aeca01b883eef9e58281f5202a1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, libcairo, libwayland"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-protocols, libwayland-cross-scanner"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgdk-pixbuf=enabled
-Dman-pages=enabled
-Dwerror=false
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper
}
