CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org
CLANDRO_PKG_DESCRIPTION="mate-menus contains the libmate-menu library, the layout configuration"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.1"
CLANDRO_PKG_SRCURL=https://github.com/mate-desktop/mate-menus/releases/download/v$CLANDRO_PKG_VERSION/mate-menus-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=d6a61d3bfbf58176fb52049f115d4e3a0d108fe5f1ef87438fafd86384e603d1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
