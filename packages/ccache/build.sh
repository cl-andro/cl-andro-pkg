CLANDRO_PKG_HOMEPAGE=https://ccache.samba.org
CLANDRO_PKG_DESCRIPTION="Compiler cache for fast recompilation of C/C++ code"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.13.6"
CLANDRO_PKG_SRCURL=https://github.com/ccache/ccache/releases/download/v$CLANDRO_PKG_VERSION/ccache-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=a7de667ca08cf67c3c8af9f213f6aa701a1188a2b3163fb74483858ce5e79fbb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fmt, libandroid-spawn, libc++, libhiredis, xxhash, zlib, zstd"

#[46/89] Building ASM object src/third_party/blake3/CMakeFiles/blake3.dir/blake3_sse2_x86-64_unix.S.o
#FAILED: src/third_party/blake3/CMakeFiles/blake3.dir/blake3_sse2_x86-64_unix.S.o
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DDEPS=LOCAL
-DENABLE_TESTING=OFF
-DHAVE_ASM_AVX2=FALSE
-DHAVE_ASM_AVX512=FALSE
-DHAVE_ASM_SSE2=FALSE
-DHAVE_ASM_SSE41=FALSE
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-spawn"
}
