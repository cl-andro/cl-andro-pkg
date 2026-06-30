CLANDRO_PKG_HOMEPAGE=https://portal.hdfgroup.org/display/support
CLANDRO_PKG_DESCRIPTION="Hierarchical Data Format 5 (HDF5)"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.14.4.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5_${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=690c1db7ba0fed4ffac61709236675ffd99d95d191e8920ee79c58d7e7ea3361
CLANDRO_PKG_DEPENDS="libc++, zlib"
CLANDRO_PKG_BREAKS="libhdf5-dev"
CLANDRO_PKG_REPLACES="libhdf5-dev"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DHDF5_BUILD_CPP_LIB=ON
-DHDF5_ENABLE_Z_LIB_SUPPORT=ON
-C$CLANDRO_PKG_BUILDER_DIR/$CLANDRO_ARCH/TryRunResults_out.cmake
"

clandro_step_post_get_source() {
	local d="hdf5-${CLANDRO_PKG_VERSION}"
	if [ -d "${d}" ]; then
		find "${d}" -mindepth 1 -maxdepth 1 -exec mv '{}' ./ \;
		rmdir "${d}"
	fi
}

clandro_step_pre_configure () {
	mkdir -p $CLANDRO_PKG_BUILDDIR/src/shared/
	cp $CLANDRO_PKG_BUILDER_DIR/$CLANDRO_ARCH/{H5Tinit.c,H5lib_settings.c} $CLANDRO_PKG_BUILDDIR/src/
	cp $CLANDRO_PKG_BUILDER_DIR/$CLANDRO_ARCH/{H5Tinit.c,H5lib_settings.c} $CLANDRO_PKG_BUILDDIR/src/shared/
	touch $CLANDRO_PKG_BUILDDIR/src/gen_SRCS.stamp1 $CLANDRO_PKG_BUILDDIR/src/gen_SRCS.stamp2
	touch $CLANDRO_PKG_BUILDDIR/src/shared/shared_gen_SRCS.stamp1 $CLANDRO_PKG_BUILDDIR/src/shared/shared_gen_SRCS.stamp2
}

clandro_step_post_configure () {
	cp $CLANDRO_PKG_BUILDER_DIR/$CLANDRO_ARCH/{H5Tinit.c,H5lib_settings.c} $CLANDRO_PKG_BUILDDIR/src/shared/
}
