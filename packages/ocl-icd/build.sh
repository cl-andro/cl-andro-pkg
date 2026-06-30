CLANDRO_PKG_HOMEPAGE=https://github.com/OCL-dev/ocl-icd
CLANDRO_PKG_DESCRIPTION="OpenCL ICD Loader"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.4"
CLANDRO_PKG_SRCURL=https://github.com/OCL-dev/ocl-icd/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1a302b71b7304cca5a36f69d017b1af2b762cc4c2dd1c0c0e2fc1933db25c9cc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-custom-layerdir=${CLANDRO_PREFIX}/etc/OpenCL/layers
--enable-custom-vendordir=${CLANDRO_PREFIX}/etc/OpenCL/vendors
--enable-official-khronos-headers
"

clandro_step_pre_configure() {
	./bootstrap
}

clandro_step_post_make_install() {
	mkdir -p "${CLANDRO_PREFIX}/lib"
	ln -fs libOpenCL.so "${CLANDRO_PREFIX}/lib/libOpenCL.so.1"
}

# https://www.khronos.org/registry/OpenCL/specs/2.2/html/OpenCL_ICD_Installation.html
# Intepreting this as providing library "libOpenCL.so" with SONAME "libOpenCL.so" on Android

# https://github.com/termux/termux-packages/issues/7510
# Removed handling of PREFIX/etc/OpenCL/vendors to match Desktop Linux ocl-icd behaviour
# Removed creation of android.icd as it never worked without modifying LD_LIBRARY_PATH on Android
# Driver packages (eg: clvk) should be the one handling the items above
