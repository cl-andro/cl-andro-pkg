CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Clutter
CLANDRO_PKG_DESCRIPTION="An integration library for using GStreamer with Clutter"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=3.0
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.27
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/clutter-gst/${_MAJOR_VERSION}/clutter-gst-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=fe69bd6c659d24ab30da3f091eb91cd1970026d431179b0724f13791e8ad9f9d
CLANDRO_PKG_DEPENDS="atk, clutter, cogl, fontconfig, freetype, gdk-pixbuf, glib, gst-plugins-base, gstreamer, gtk3, harfbuzz, json-glib, libcairo, libx11, libxcomposite, libxdamage, libxext, libxfixes, libxi, libxrandr, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}

clandro_step_post_configure() {
	touch clutter-gst/g-ir-{compiler,scanner}
}
