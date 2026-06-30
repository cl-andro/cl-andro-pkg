CLANDRO_PKG_HOMEPAGE=https://github.com/groonga/groonga/
CLANDRO_PKG_DESCRIPTION="An embeddable fulltext search engine"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="16.0.2"
CLANDRO_PKG_SRCURL="https://github.com/groonga/groonga/releases/download/v${CLANDRO_PKG_VERSION}/groonga-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=4bb7c995ef370b2370ed16fe78ddeebe827da22127d1cecf0696f8f5f28dde69
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libarrow-cpp, libc++, liblz4, libstemmer, onigmo, simdjson, xxhash, zlib, zstd"
CLANDRO_PKG_BUILD_DEPEPNDS="rapidjson"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DGRN_WITH_APACHE_ARROW=ON
-DGRN_WITH_LIBSTEMMER=system
-DGRN_WITH_LZ4=system
-DGRN_WITH_ONIGMO=ON
-DGRN_WITH_BUNDLED_ONIGMO=OFF
-DGRN_WITH_RAPIDJSON=system
-DGRN_WITH_SIMDJSON=system
-DGRN_WITH_XXHASH=system
-DGRN_WITH_ZLIB=system
-DGRN_WITH_ZSTD=system
-DGRN_WITH_OPENZL=no
"

clandro_step_pre_configure() {
	# llama.cpp fails to build for 32 bit targets
	if [ "$CLANDRO_ARCH" = i686 ] || [ "$CLANDRO_ARCH" = arm ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DGRN_WITH_LLAMA_CPP=no"
	fi

	LDFLAGS+=" -fopenmp -static-openmp"
}
