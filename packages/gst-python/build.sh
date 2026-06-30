CLANDRO_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Python bindings for GStreamer"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.2"
CLANDRO_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-python/gst-python-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=12fdd8e19af97d797a6b2c195228e6c9edc4cddfa68274912b78ef66068ad822
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gst-plugins-base, gst-plugins-bad, gstreamer, pygobject, python"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=disabled
"
