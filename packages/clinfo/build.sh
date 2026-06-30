CLANDRO_PKG_HOMEPAGE=https://github.com/Oblomov/clinfo
CLANDRO_PKG_DESCRIPTION="Print all known information about all available OpenCL platforms and devices in the system"
CLANDRO_PKG_LICENSE="CC0-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.25.02.14"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Oblomov/clinfo/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=48b77dc33315e6f760791a2984f98ea4bff28504ff37d460d8291585f49fcd3a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_DEPENDS="opencl-headers"
CLANDRO_PKG_DEPENDS="ocl-icd"
CLANDRO_PKG_BUILD_IN_SRC=true

# https://github.com/Oblomov/clinfo/blob/master/Makefile#L7
# clinfo has added detection for building on device
# and wrapper for running on device
# which directly link against /vendor/lib64/libOpenCL.so
# This conflicts with using ocl-icd
CLANDRO_PKG_EXTRA_MAKE_ARGS="OS=Linux"

CLANDRO_PKG_EXTRA_MAKE_ARGS+="
MANDIR=$CLANDRO_PREFIX/share/man
"
