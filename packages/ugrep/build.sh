CLANDRO_PKG_HOMEPAGE="https://github.com/Genivia/ugrep"
CLANDRO_PKG_DESCRIPTION="A faster, user-friendly and compatible grep replacement"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.8.1"
CLANDRO_PKG_SRCURL="https://github.com/Genivia/ugrep/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=204473f377bdfd2aa2c9fa71074dad799e1848d91510d41c2f36ec0edcf5bc43
CLANDRO_PKG_DEPENDS="brotli, libbz2, libc++, liblz4, liblzma, pcre2, zlib, zstd"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--includedir=$CLANDRO_PREFIX/include
--with-brotli=$CLANDRO_PREFIX
--with-pcre2=$CLANDRO_PREFIX
--with-zlib=$CLANDRO_PREFIX
--with-bzlib=$CLANDRO_PREFIX
--with-lzma=$CLANDRO_PREFIX
--with-lz4=$CLANDRO_PREFIX
--with-zstd=$CLANDRO_PREFIX
--disable-static
--disable-sse2
--disable-avx2
"

clandro_step_pre_configure() {
	autoreconf -fi
}
