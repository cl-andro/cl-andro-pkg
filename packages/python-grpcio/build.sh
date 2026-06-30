CLANDRO_PKG_HOMEPAGE=https://grpc.io/
CLANDRO_PKG_DESCRIPTION="High performance, open source, general RPC framework that puts mobile and HTTP/2 first"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_SRCURL=git+https://github.com/grpc/grpc
CLANDRO_PKG_VERSION="1.80.0"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_DEPENDS="abseil-cpp, c-ares, ca-certificates, libc++, libre2, openssl, python, python-pip, zlib"
CLANDRO_PKG_BUILD_DEPENDS="gflags, gflags-static"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, setuptools, 'Cython>=3.0.0'"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	rm CMakeLists.txt Makefile Rakefile

	export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
	export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
	export GRPC_PYTHON_BUILD_SYSTEM_CARES=1
	export GRPC_PYTHON_BUILD_SYSTEM_RE2=1
	export GRPC_PYTHON_BUILD_SYSTEM_ABSL=1
	export GRPC_PYTHON_BUILD_WITH_CYTHON=1
}
