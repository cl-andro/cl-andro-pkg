CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/xfce4-session/start
CLANDRO_PKG_DESCRIPTION="A session manager for XFCE environment"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.4"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfce4-session/${CLANDRO_PKG_VERSION%.*}/xfce4-session-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=805c373378d080754d69dd2f20db95cdc066c89a4f024a41435ca0d66571c402
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, gtk-layer-shell, libcairo, libice, libsm, libwnck, libx11, libxfce4ui, libxfce4util, libxfce4windowing, pango, xfconf, xorg-iceauth, xorg-xrdb"
CLANDRO_PKG_BUILD_DEPENDS="xfce4-dev-tools"
CLANDRO_PKG_RECOMMENDS="gnupg, hicolor-icon-theme, xfce4-settings, xfdesktop, xfwm4"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_ICEAUTH=${CLANDRO_PREFIX}/bin/iceauth
--disable-debug
--enable-gtk-layer-shell
--enable-wayland
--enable-x11
--with-wayland-session-prefix=${CLANDRO_PREFIX}
--with-xsession-prefix=${CLANDRO_PREFIX}
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
