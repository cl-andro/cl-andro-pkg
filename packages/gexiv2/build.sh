CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/gexiv2
CLANDRO_PKG_DESCRIPTION="A GObject-based Exiv2 wrapper"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gexiv2/${CLANDRO_PKG_VERSION%.*}/gexiv2-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=606c28aaae7b1f3ef5c8eabe5e7dffd7c5a1c866d25b7671fb847fe287a72b8b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="exiv2, glib, libc++"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
-Dintrospection=true
-Dvapi=true
-Dpython3=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
