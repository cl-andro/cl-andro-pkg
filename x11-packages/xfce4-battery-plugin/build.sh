CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-battery-plugin/start
CLANDRO_PKG_DESCRIPTION="A battery monitor plugin for the Xfce panel"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-battery-plugin/${CLANDRO_PKG_VERSION%.*}/xfce4-battery-plugin-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1dba8f470d2b12517e7b86d83cd2ebf13eb57ff1a01a4f2d2d156cf5194d97b6
CLANDRO_PKG_DEPENDS="glib, gtk3, clandro-api, libxfce4ui, libxfce4util, xfce4-panel"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	cp -f $CLANDRO_PKG_BUILDER_DIR/libacpi.c $CLANDRO_PKG_SRCDIR/panel-plugin/
}
