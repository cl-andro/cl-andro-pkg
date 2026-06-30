CLANDRO_PKG_HOMEPAGE=https://www.zlib.net/
CLANDRO_PKG_DESCRIPTION="Compression library implementing the deflate compression method found in gzip and PKZIP"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.2"
CLANDRO_PKG_SRCURL=https://github.com/madler/zlib/releases/download/v${CLANDRO_PKG_VERSION}/zlib-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=d7a0654783a4da529d1bb793b7ad9c3318020af77667bcae35f95d0e42a792f3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="ndk-sysroot (<< 19b-3), zlib-dev"
CLANDRO_PKG_REPLACES="ndk-sysroot (<< 19b-3), zlib-dev"

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" = "aarch64" ]; then
		CFLAGS+=" -march=armv8-a+crc"
		CXXFLAGS+=" -march=armv8-a+crc"
	fi

	# Fix relocation issues when linking with libz.a
	CFLAGS+=" -fPIC"
	CXXFLAGS+=" -fPIC"

	# Fix linker script error for zlib 1.3
	LDFLAGS+=" -Wl,--undefined-version"
}

clandro_step_configure() {
	"$CLANDRO_PKG_SRCDIR/configure" --prefix=$CLANDRO_PREFIX --shared
}
