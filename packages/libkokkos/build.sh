CLANDRO_PKG_HOMEPAGE=https://github.com/kokkos
CLANDRO_PKG_DESCRIPTION="Implements a programming model in C++ for writing performance portable applications"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYRIGHT.md"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.1.1"
CLANDRO_PKG_SRCURL=https://github.com/kokkos/kokkos/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=77cbde0066f5ea9343d35be452826b6b226ceacb385239c28cc9688baf471cc0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DKokkos_ENABLE_LIBDL=OFF
"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
}
