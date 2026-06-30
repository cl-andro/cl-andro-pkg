CLANDRO_PKG_HOMEPAGE=https://github.com/vkmark/vkmark
CLANDRO_PKG_DESCRIPTION="Vulkan benchmark"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_LICENSE_FILE="COPYING-LGPL2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2025.01"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/vkmark/vkmark/archive/refs/tags/${CLANDRO_PKG_VERSION}/vkmark-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=1ae362844344d0f9878b7a3f13005f77eae705108892a4e8abf237d452d37edc
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="assimp, libc++, libxcb, vulkan-loader-generic, xcb-util-wm"
CLANDRO_PKG_BUILD_DEPENDS="glm, vulkan-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Dxcb=true -Dkms=false"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-cross-scanner"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper
	export PATH="$CLANDRO_PREFIX/opt/libwayland/cross/bin:$PATH"
}
