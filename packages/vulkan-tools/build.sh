CLANDRO_PKG_HOMEPAGE=https://github.com/KhronosGroup/Vulkan-Tools
CLANDRO_PKG_DESCRIPTION="Vulkan Tools and Utilities"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.351"
CLANDRO_PKG_SRCURL=https://github.com/KhronosGroup/Vulkan-Tools/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7eeff90a76f82b2a94eac0515ce8dbf0b8f7bf9199b1cd04d70ec44af3bf07ea
CLANDRO_PKG_DEPENDS="libc++, libwayland, libx11, libxcb, vulkan-loader"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-protocols, vulkan-headers (=${CLANDRO_PKG_VERSION}), vulkan-volk"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="vulkan-loader"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_CUBE=ON
-DBUILD_ICD=OFF
-DBUILD_WSI_WAYLAND_SUPPORT=ON
-DBUILD_WSI_XCB_SUPPORT=ON
-DBUILD_WSI_XLIB_SUPPORT=ON
-DVULKAN_HEADERS_INSTALL_DIR=${CLANDRO_PREFIX}
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper
}
