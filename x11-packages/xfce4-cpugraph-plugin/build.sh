CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-cpugraph-plugin/start
CLANDRO_PKG_DESCRIPTION="Graphical representation of the CPU load"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@knyipab"
CLANDRO_PKG_VERSION="1.3.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-cpugraph-plugin/${CLANDRO_PKG_VERSION%.*}/xfce4-cpugraph-plugin-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=c3305edea13ae785ea8b7ce8efbb40b5d5cac69a6f8bf790e4f2efaa780ca097
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk3, libandroid-glob, libc++, libcairo, libxfce4ui, libxfce4util, xfce4-panel, xfconf"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
