CLANDRO_PKG_HOMEPAGE=https://github.com/samtools/htslib
CLANDRO_PKG_DESCRIPTION="C library for high-throughput sequencing data formats"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.23.1"
CLANDRO_PKG_SRCURL=https://github.com/samtools/htslib/releases/download/${CLANDRO_PKG_VERSION}/htslib-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=f8a3f36effeec38f043c53ab1f2d9ed45064f14205c5ef8e3c815763b90803c4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="libbz2, liblzma, zlib, libdeflate, libcurl"

# error: assigning to 'uint8x8_t' (vector of 8 'uint8_t' values) from incompatible type 'int'
CLANDRO_PKG_EXCLUDED_ARCHES="arm"

clandro_step_pre_configure() {
	autoreconf -fi
}
