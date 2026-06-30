CLANDRO_PKG_HOMEPAGE=https://grpc.io/
CLANDRO_PKG_DESCRIPTION="High performance, open source, general RPC framework that puts mobile and HTTP/2 first"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_SRCURL=git+https://github.com/grpc/grpc
CLANDRO_PKG_VERSION="1.80.0"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_DEPENDS="abseil-cpp, c-ares, ca-certificates, libc++, libprotobuf, libre2, openssl, protobuf, zlib"
CLANDRO_PKG_BREAKS="libgrpc-dev"
CLANDRO_PKG_REPLACES="libgrpc-dev"
CLANDRO_PKG_BUILD_DEPENDS="gflags, gflags-static"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_STRIP=$(command -v strip)
-DGIT_EXECUTABLE=$(command -v git)
-DBUILD_SHARED_LIBS=ON
-DgRPC_ABSL_PROVIDER=package
-DgRPC_CARES_PROVIDER=package
-DgRPC_PROTOBUF_PROVIDER=package
-DgRPC_SSL_PROVIDER=package
-DgRPC_RE2_PROVIDER=package
-DgRPC_ZLIB_PROVIDER=package
-DgRPC_GFLAGS_PROVIDER=package
-DRUN_HAVE_POSIX_REGEX=0
-DRUN_HAVE_STD_REGEX=0
-DRUN_HAVE_STEADY_CLOCK=0
-DProtobuf_PROTOC_LIBRARY=$CLANDRO_PREFIX/lib/libprotoc.so
"

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	export LD=gcc
	export LDXX=g++

	# -Wno-error=class-memaccess is used to avoid
	# src/core/lib/security/credentials/oauth2/oauth2_credentials.cc:336:61: error: ‘void* memset(void*, int, size_t)’ clearing an object of non-trivial type ‘struct grpc_oauth2_token_fetcher_credentials’; use assignment or value-initialization instead [-Werror=class-memaccess]
	# memset(c, 0, sizeof(grpc_oauth2_token_fetcher_credentials));
	# when building version 1.17.2:
	CXXFLAGS="-Wno-error=class-memaccess" \
		CFLAGS="-Wno-implicit-fallthrough" \
		cmake \
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
		-G Ninja \
		"$CLANDRO_PKG_SRCDIR"

	ninja grpc_cpp_plugin
}

clandro_step_pre_configure() {
	clandro_setup_protobuf
	clandro_setup_cmake
	clandro_setup_ninja

	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR:$PATH
	export GRPC_CROSS_COMPILE=true

	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"
	LDFLAGS+=" $($CLANDRO_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
}
