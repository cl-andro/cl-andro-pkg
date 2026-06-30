CLANDRO_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="GStreamer base plug-ins"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.2"
CLANDRO_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=4db76b3619280037a4047de7d9dbb38613a4272dcc40efb333257124635a888d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, graphene, gstreamer, libandroid-shmem, libjpeg-turbo, libogg, libopus, libpng, libtheora, libvorbis, libx11, libxcb, libxext, libxi, libxv, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, opengl"
CLANDRO_PKG_RECOMMENDS="opengl"
CLANDRO_PKG_BREAKS="gst-plugins-base-dev"
CLANDRO_PKG_REPLACES="gst-plugins-base-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false

# wrap-mode=nodownload prevents downloading gl-headers which conflicts with libglvnd-dev
# -Dgl_winsys=egl,surfaceless,x11,android (disabling wayland)
# prevents 'ld.lld: error: undefined symbol: gst_gl_display_wayland_get_type'
# if wayland libraries are present in $CLANDRO_PREFIX before building gst-plugins-base
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dtests=disabled
-Dexamples=disabled
-Dpango=disabled
--wrap-mode=nodownload
-Dgl_winsys=egl,surfaceless,x11,android
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	LDFLAGS+=" -landroid-shmem"
}

clandro_step_post_massage() {
	local dir="include/GL"
	if [[ -d "${CLANDRO_PKG_MASSAGEDIR}${CLANDRO_PREFIX}/$dir" ]]; then
		clandro_error_exit "$dir should not exist in $CLANDRO_PKG_NAME!"
	fi
}
