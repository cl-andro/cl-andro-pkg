CLANDRO_PKG_HOMEPAGE=https://github.com/DLTcollab/sse2neon
CLANDRO_PKG_DESCRIPTION="A C/C++ header file that converts Intel SSE intrinsics to Arm/Aarch64 NEON intrinsics"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9.1"
CLANDRO_PKG_SRCURL=https://github.com/DLTcollab/sse2neon/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6b70e7cb8c5ce4641002b85deaafe97efdf9ade9b49884edeaf678b35f0e132f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make() {
	# dont build tests
	:
}

clandro_step_make_install() {
	# Makefile dont have install rule
	install -Dm600 sse2neon.h "${CLANDRO_PREFIX}"/include
}
