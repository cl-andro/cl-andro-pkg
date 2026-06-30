CLANDRO_PKG_HOMEPAGE=https://github.com/protocolbuffers/protobuf
CLANDRO_PKG_DESCRIPTION="Protocol buffers C++ library"
# utf8_range is licensed under MIT
CLANDRO_PKG_LICENSE="BSD 3-Clause, MIT"
CLANDRO_PKG_LICENSE_FILE="
LICENSE
third_party/utf8_range/LICENSE
"
CLANDRO_PKG_MAINTAINER="@clandro"
# When bumping version:
# - update SHA256 checksum for $_PROTOBUF_ZIP in
#     $CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_protobuf.sh
# - ALWAYS bump revision of reverse dependencies and rebuild them.
CLANDRO_PKG_VERSION="2:33.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/protocolbuffers/protobuf/archive/refs/tags/v${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=0c98bb704ceb4e68c92f93907951ca3c36130bc73f87264e8c0771a80362ac97
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="abseil-cpp, libc++, zlib"
CLANDRO_PKG_BREAKS="libprotobuf-dev, protobuf-dev, protobuf-static, libutf8-range"
CLANDRO_PKG_REPLACES="libprotobuf-dev, protobuf-dev, protobuf-static, libutf8-range"
CLANDRO_PKG_CONFLICTS="protobuf-static"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dprotobuf_ABSL_PROVIDER=package
-Dprotobuf_BUILD_TESTS=OFF
-DBUILD_SHARED_LIBS=ON
-DCMAKE_INSTALL_LIBDIR=lib
"
