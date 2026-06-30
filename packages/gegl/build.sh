CLANDRO_PKG_HOMEPAGE=https://gegl.org/
CLANDRO_PKG_DESCRIPTION="Data flow based image processing framework"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.70"
CLANDRO_PKG_SRCURL="https://gitlab.gnome.org/GNOME/gegl/-/archive/GEGL_${CLANDRO_PKG_VERSION//./_}/gegl-GEGL_${CLANDRO_PKG_VERSION//./_}.tar.gz"
CLANDRO_PKG_SHA256=0bd31cc39243be1e90ab01680c69ff555bec7d42b3b50688d606f7226b3ada87
CLANDRO_PKG_DEPENDS="babl, ffmpeg, gdk-pixbuf, glib, imath, json-glib, libandroid-support, libc++, libcairo, libjasper, libjpeg-turbo, libpng, libraw, librsvg, libtiff, libwebp, littlecms, openexr, pango, poppler"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac, xorgproto"
CLANDRO_PKG_BREAKS="gegl-dev"
CLANDRO_PKG_REPLACES="gegl-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
