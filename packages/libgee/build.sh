CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Libgee
CLANDRO_PKG_DESCRIPTION="A collection library providing GObject-based interfaces and classes for commonly used data structures"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.20.8"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libgee/${CLANDRO_PKG_VERSION%.*}/libgee-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=189815ac143d89867193b0c52b7dc31f3aa108a15f04d6b5dca2b6adfad0b0ee
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
--enable-vala
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
