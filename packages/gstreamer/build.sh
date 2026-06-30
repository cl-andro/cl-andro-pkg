CLANDRO_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Open source multimedia framework"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.2"
CLANDRO_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=ce5cd44d4ffeafdcc3dddaa072b2179c0b7cb1abf4e6c5d18d4375f8a39fe491
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_BUILD_DEPENDS="bash-completion, g-ir-scanner"
CLANDRO_PKG_SUGGESTS="gst-plugins-base, gst-plugins-libav, gst-plugins-good, gst-plugins-bad, gst-plugins-ugly"
CLANDRO_PKG_BREAKS="gstreamer-dev"
CLANDRO_PKG_REPLACES="gstreamer-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dcheck=disabled
-Dtests=disabled
-Dexamples=disabled
-Dbenchmarks=disabled
-Dlibunwind=disabled
-Dlibdw=disabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
