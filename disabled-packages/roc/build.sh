## * Requires pulseaudio build and source directory.
## * Uses scons build system which is not good at cross-compiling.

CLANDRO_PKG_HOMEPAGE=https://roc-project.github.io
CLANDRO_PKG_DESCRIPTION="Roc real-time streaming over the network"
CLANDRO_PKG_LICENSE="LGPL-2.0, MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1.1
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/roc-project/roc/archive/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=2aa63061b586a5f16cfcb0bfe304015a6effdcb373513cb62e76283bde7dd104
CLANDRO_PKG_DEPENDS="libltdl, libopenfec, libuv, pulseaudio"
CLANDRO_PKG_BREAKS="roc-dev"
CLANDRO_PKG_REPLACES="roc-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	SCONS_CONFIGURE_ARGS=""
	SCONS_CONFIGURE_ARGS+=" --prefix=$CLANDRO_PREFIX"
	SCONS_CONFIGURE_ARGS+=" --host=$CLANDRO_HOST_PLATFORM"
	SCONS_CONFIGURE_ARGS+=" --compiler=clang"
	SCONS_CONFIGURE_ARGS+=" --disable-tools"
	SCONS_CONFIGURE_ARGS+=" --disable-tests"
	SCONS_CONFIGURE_ARGS+=" --disable-examples"
	SCONS_CONFIGURE_ARGS+=" --disable-doc"
	SCONS_CONFIGURE_ARGS+=" --disable-sox"
	#SCONS_CONFIGURE_ARGS+=" --disable-openfec"
	SCONS_CONFIGURE_ARGS+=" --enable-pulseaudio-modules"
	SCONS_CONFIGURE_ARGS+=" --with-openfec-includes=$CLANDRO_PREFIX/include/openfec"
	SCONS_CONFIGURE_ARGS+=" --with-pulseaudio=$CLANDRO_TOPDIR/pulseaudio/src"
	SCONS_CONFIGURE_ARGS+=" --with-pulseaudio-build-dir=$CLANDRO_TOPDIR/pulseaudio/build"

	scons $SCONS_CONFIGURE_ARGS
}

clandro_step_make_install() {
	scons $SCONS_CONFIGURE_ARGS install
}
