CLANDRO_PKG_HOMEPAGE=https://www.monetdb.org/
CLANDRO_PKG_DESCRIPTION="A high-performance database kernel for query-intensive applications"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="11.55.5"
CLANDRO_PKG_SRCURL="https://www.monetdb.org/downloads/sources/archive/MonetDB-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=480c921a45b54c610dee9a17147f0e89ae74c31516b9250e5c8f2371e1bd70c2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-sysv-semaphore, libbz2, libcurl, libiconv, liblz4, liblzma, libxml2, netcdf-c, pcre2, readline, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DODBC=OFF
-DTESTING=OFF
"

# ```
# In file included from [...]/src/common/stream/stream.c:58:
# In file included from [...]/src/common/stream/stream_internal.h:19:
# [...]/src/common/utils/matomic.h:90:2: error: "we need _Atomic(unsigned long long) to be lock free"
# #error "we need _Atomic(unsigned long long) to be lock free"
#  ^
# ```
CLANDRO_PKG_EXCLUDED_ARCHES="i686"

clandro_step_post_get_source() {
	find . -name '*.c' | xargs -n 1 sed -i \
		-e 's:"\(/tmp\):"'$CLANDRO_PREFIX'\1:g'
}

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-sysv-semaphore -lm"
}
