CLANDRO_PKG_HOMEPAGE=https://github.com/OpenAtomFoundation/pikiwidb
CLANDRO_PKG_DESCRIPTION="Redis-Compatible database developed by Qihoo's infrastructure team"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=(3.5.6
					1.0.7)
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=("https://github.com/OpenAtomFoundation/pikiwidb/archive/refs/tags/v${CLANDRO_PKG_VERSION[0]}.tar.gz"
					"https://github.com/pikiwidb/rediscache/archive/refs/tags/v${CLANDRO_PKG_VERSION[1]}.tar.gz")
CLANDRO_PKG_SHA256=(b8081375426d1769ecc4a5fe70c5109589ef374f5d9030ea0adc4ea5a1dab9fa
					6d09b5699030e74914da085a10fd6010336572b30894d93e4f024fa67d36f2a8)
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="abseil-cpp, fmt, gflags, google-glog, libc++, libprotobuf, librocksdb, zlib"
# required during build, but binary does not become linked to them
CLANDRO_PKG_BUILD_DEPENDS="googletest, liblz4, libsnappy, zstd"
CLANDRO_PKG_CONFLICTS="pika"
CLANDRO_PKG_BREAKS="pika"
CLANDRO_PKG_REPLACES="pika"
# src/pika_monotonic_time.cc:47:2: error: "Unsupported architecture for Linux"
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	# build and install rediscache component
	(
	export CLANDRO_PKG_SRCDIR+="/rediscache-${CLANDRO_PKG_VERSION[1]}"
	export CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR/build"
	mkdir -p "$CLANDRO_PKG_BUILDDIR"
	cd "$CLANDRO_PKG_BUILDDIR"
	clandro_step_configure
	clandro_step_make
	ninja install
	)
	cd "$CLANDRO_PKG_BUILDDIR"

	clandro_setup_protobuf
	export PROTOC_PATH="$(dirname $(command -v protoc))"

	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"
	# from PREFIX/lib/cmake/glog/glog-targets.cmake
	CPPFLAGS+=" -DGLOG_USE_GLOG_EXPORT -DGLOG_USE_GFLAGS"
	CPPFLAGS+=" -DHAS_PTHREAD_SETNAME_NP"
	CPPFLAGS+=" -I$CLANDRO_PREFIX/include/rocksdb"

	LDFLAGS+=" $($CLANDRO_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
}

clandro_step_make_install () {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "$CLANDRO_PKG_BUILDDIR/pika"
	install -Dm600 -t "$CLANDRO_PREFIX/share/pika" "$CLANDRO_PKG_SRCDIR/conf/pika.conf"
}
