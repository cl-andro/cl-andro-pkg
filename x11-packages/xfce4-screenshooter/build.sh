CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/apps/xfce4-screenshooter/start
CLANDRO_PKG_DESCRIPTION="The Xfce4-screenshooter is an application that can be used to take snapshots of your desktop screen."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION="1.11.3"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-screenshooter/${CLANDRO_PKG_VERSION%.*}/xfce4-screenshooter-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1f6a14f7d1b0c440f31e24a8cc4fe2996185357fa786f0c2cdfe564ef673a710
CLANDRO_PKG_DEPENDS="atk, exo, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libx11, libxext, libxfce4ui, libxfce4util, libxfixes, libwayland, pango, xfce4-panel, xfconf, zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dwayland=enabled
-Dx11=enabled
-Dxfixes=enabled
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper
}
