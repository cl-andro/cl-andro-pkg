CLANDRO_PKG_HOMEPAGE=https://github.com/sabnzbd/sabctools
CLANDRO_PKG_DESCRIPTION="C implementations of functions for use within SABnzbd"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="9.4.0"
CLANDRO_PKG_SRCURL=https://github.com/sabnzbd/sabctools/releases/download/v${CLANDRO_PKG_VERSION}/sabctools-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=264451b599f3a7cddd30a5e2baa3976939bc50ea649219a31f6cac4bc4d8d032
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, python"
CLANDRO_PKG_BUILD_DEPENDS="libcpufeatures"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"

clandro_step_pre_configure() {
	export CXXFLAGS+=" -fPIC -I$CLANDRO_PREFIX/include/ndk_compat"
	export CFLAGS+=" -I$CLANDRO_PREFIX/include/ndk_compat"
	export LDFLAGS+=" -l:libndk_compat.a"
}
