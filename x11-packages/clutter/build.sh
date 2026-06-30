CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Clutter
CLANDRO_PKG_DESCRIPTION="An open source software library for creating fast, compelling, portable, and dynamic graphical user interfaces"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=1.26
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.4
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/clutter/${_MAJOR_VERSION}/clutter-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=8b48fac159843f556d0a6be3dbfc6b083fc6d9c58a20a49a6b4919ab4263c4e6
CLANDRO_PKG_DEPENDS="atk, cogl, fontconfig, freetype, gdk-pixbuf, glib, gtk3, harfbuzz, json-glib, libcairo, libx11, libxcomposite, libxdamage, libxext, libxfixes, libxi, libxrandr, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
--enable-egl-backend=no
"

clandro_step_pre_configure() {
	clandro_setup_gir

	export GLIB_GENMARSHAL=glib-genmarshal
	export GOBJECT_QUERY=gobject-query
	export GLIB_MKENUMS=glib-mkenums
	export GLIB_COMPILE_RESOURCES=glib-compile-resources
}
