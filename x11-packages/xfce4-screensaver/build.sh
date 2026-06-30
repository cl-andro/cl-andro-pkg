CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/apps/screensaver/start
CLANDRO_PKG_DESCRIPTION="Xfce Screensaver is a screen saver and locker that aims to have simple, sane, secure defaults and be well integrated with the desktop."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION="4.20.2"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-screensaver/${CLANDRO_PKG_VERSION%.*}/xfce4-screensaver-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=5032f60a31df5e50a80512e301b595be5ea6a6bd762cdd95cacc24cbd29a01d7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus, dbus-glib, garcon, gdk-pixbuf, glib, gtk3, libcairo, libwnck, libx11, libxext, libxfce4ui, libxfce4util, libxklavier, libxss, opengl, pango, clandro-auth, xfconf"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dauthentication-scheme=none
-Dsession-manager=none
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
