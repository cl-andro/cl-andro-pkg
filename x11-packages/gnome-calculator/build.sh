CLANDRO_PKG_HOMEPAGE=https://apps.gnome.org/Calculator
CLANDRO_PKG_DESCRIPTION="GNOME Scientific calculator"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.0"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gnome-calculator/${CLANDRO_PKG_VERSION%%.*}/gnome-calculator-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=8053d6891565e882874b65c1db51c5bf310005eb788b8bac3546390743350a90
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk4, gtksourceview5, libadwaita, libgee, libmpc, libmpfr, libsoup3, libxml2"
CLANDRO_PKG_BUILD_DEPENDS="blueprint-compiler, g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_RECOMMENDS="gnome-calculator-help"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_bpc
}
