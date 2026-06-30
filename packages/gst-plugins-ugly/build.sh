CLANDRO_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="GStreamer Ugly Plug-ins"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.2"
CLANDRO_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=fe39a5ee7115e37de9eb65d899ec84c93e6e26ed3ffe25c6d5176cececbab572
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gst-plugins-base"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=disabled
"
