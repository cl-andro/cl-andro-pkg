CLANDRO_PKG_HOMEPAGE=https://abseil.io/
CLANDRO_PKG_DESCRIPTION="Abseil C++ Common Libraries"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Do not forget to rebuild revdeps along with EVERY "major" version bump.
CLANDRO_PKG_VERSION="20250814.1"
CLANDRO_PKG_SRCURL=https://github.com/abseil/abseil-cpp/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1692f77d1739bacf3f94337188b78583cf09bab7e420d2dc6c5605a4f86785a1
# updating this will break libprotobuf
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_CONFLICTS="libgrpc (<< 1.52.0-1)"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
