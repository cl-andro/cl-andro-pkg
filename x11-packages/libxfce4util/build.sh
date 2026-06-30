CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/libxfce4util/start
CLANDRO_PKG_DESCRIPTION="Basic utility non-GUI functions for XFCE"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/libxfce4util/${CLANDRO_PKG_VERSION%.*}/libxfce4util-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=84bfc4daab9e466193540c3665eee42b2cf4d24e3f38fc3e8d1e0a2bebe3b8f1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib"
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
}
