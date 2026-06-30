CLANDRO_PKG_HOMEPAGE=https://sourceware.org/elfutils/
CLANDRO_PKG_DESCRIPTION="ELF object file access library"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.193"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://sourceware.org/elfutils/ftp/${CLANDRO_PKG_VERSION}/elfutils-${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=7857f44b624f4d8d421df851aaae7b1402cfe6bcdd2d8049f15fc07d3dde7635
# libandroid-support for langinfo.
CLANDRO_PKG_DEPENDS="libandroid-support, zlib, zstd, json-c"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_c99=yes --disable-symbol-versioning"
CLANDRO_PKG_CONFLICTS="libelf-dev"
CLANDRO_PKG_REPLACES="libelf-dev"

# https://github.com/llvm/llvm-project/issues/71925#issuecomment-1987141438
#
# In file included from ../../elfutils-0.191/src/srcfiles.cxx:50:
# ...
# ./stack:1:1: error: expected unqualified-id
#
# do not set this to true due to clang bug
CLANDRO_PKG_BUILD_IN_SRC=false

clandro_step_pre_configure() {
	CXXFLAGS+=" -Wno-unused-const-variable -Wno-error=unused-function"
	CFLAGS+=" -Wno-error=unused-value -Wno-error=format-nonliteral -Wno-error -Wno-error=unused-function"

	# Exposes ACCESSPERMS in <sys/stat.h> which elfutils uses
	CFLAGS+=" -D__USE_BSD"

	CFLAGS+=" -DFNM_EXTMATCH=0"

	if [ "$CLANDRO_ARCH" = "arm" ]; then
		CFLAGS="${CFLAGS/-Oz/-O1}"
	fi

	cp $CLANDRO_PKG_BUILDER_DIR/stdio_ext.h .
	cp $CLANDRO_PKG_BUILDER_DIR/obstack.h src
	cp $CLANDRO_PKG_BUILDER_DIR/qsort_r.h .
	cp $CLANDRO_PKG_BUILDER_DIR/aligned_alloc.c libelf
	cp -r $CLANDRO_PKG_BUILDER_DIR/search src/

	autoreconf -ivf
}
