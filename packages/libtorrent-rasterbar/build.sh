CLANDRO_PKG_HOMEPAGE=https://libtorrent.org/
CLANDRO_PKG_DESCRIPTION="A feature complete C++ bittorrent implementation focusing on efficiency and scalability"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.12"
CLANDRO_PKG_SRCURL="https://github.com/arvidn/libtorrent/releases/download/v${CLANDRO_PKG_VERSION}/libtorrent-rasterbar-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=25b898d02e02e43ee9a8ea5480c20007f129091b5754d0283f94e4d51d11a19e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="boost, libc++, openssl, python"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-Dboost-python-module-name=python
-Dpython-bindings=ON
"

clandro_step_pre_configure() {
	# We don't get build-python in path until clandro_setup_python_pip is called in
	# clandro_step_get_dependencies_python
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DPython3_EXECUTABLE=$(command -v build-python)"
}
