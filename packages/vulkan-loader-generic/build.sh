CLANDRO_PKG_HOMEPAGE=https://github.com/KhronosGroup/Vulkan-Loader
CLANDRO_PKG_DESCRIPTION="Vulkan Loader"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.351"
CLANDRO_PKG_SRCURL=https://github.com/KhronosGroup/Vulkan-Loader/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=16d194578e01c1909cc46dd0269a916684e317764e5d604372ac56e8f8f66506
CLANDRO_PKG_BUILD_DEPENDS="vulkan-headers (=${CLANDRO_PKG_VERSION}), libx11, libxcb, libxrandr"
CLANDRO_PKG_CONFLICTS="vulkan-loader-android"
CLANDRO_PKG_PROVIDES="vulkan-loader-android"
CLANDRO_PKG_RECOMMENDS="vulkan-icd"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_REPOLOGY_METADATA_NAME=vulkan-loader
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DCMAKE_SYSTEM_NAME=Linux
-DENABLE_WERROR=OFF
-DVULKAN_HEADERS_INSTALL_DIR=$CLANDRO_PREFIX
-DPython3_EXECUTABLE=$(command -v python3)
--trace
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -Wno-typedef-redefinition"
}

clandro_step_post_make_install() {
	# Sanity check
	echo "INFO: ========== vulkan.pc =========="
	cat "$CLANDRO_PREFIX/lib/pkgconfig/vulkan.pc"
	echo "INFO: ========== vulkan.pc =========="

	# Lots of apps will search libvulkan.so.1
	local e=0
	[ ! -e "$CLANDRO_PREFIX"/lib/libvulkan.so ] && e=1
	[ ! -e "$CLANDRO_PREFIX"/lib/libvulkan.so.1 ] && e=1
	if [[ "${e}" != 0 ]]; then
		clandro_error_exit "
		Symlink check failed!
		$(file "$CLANDRO_PREFIX"/lib/libvulkan.so)
		$(file "$CLANDRO_PREFIX"/lib/libvulkan.so.1)
		"
	fi
}
