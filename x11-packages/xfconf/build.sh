CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/xfconf/start
CLANDRO_PKG_DESCRIPTION="Flexible, easy-to-use configuration management system"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.0"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfconf/${CLANDRO_PKG_VERSION%.*}/xfconf-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=8bc43c60f1716b13cf35fc899e2a36ea9c6cdc3478a8f051220eef0f53567efd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libxfce4util"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac, xfce4-dev-tools"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--enable-introspection=yes
--enable-vala=yes
--enable-gtk-doc-html=no
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
