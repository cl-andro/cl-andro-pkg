CLANDRO_PKG_HOMEPAGE=https://source.android.com/devices/graphics/arch-vulkan
CLANDRO_PKG_DESCRIPTION="Vulkan Loader for Android"
CLANDRO_PKG_LICENSE="NCSA"
CLANDRO_PKG_MAINTAINER="@clandro"
# Version should be equal to CLANDRO_NDK_{VERSION_NUM,REVISION} in
# scripts/properties.sh
CLANDRO_PKG_VERSION=29
CLANDRO_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${CLANDRO_PKG_VERSION}-linux.zip
CLANDRO_PKG_SHA256=4abbbcdc842f3d4879206e9695d52709603e52dd68d3c1fff04b3b5e7a308ecf
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true

# Desktop Vulkan Loader
# https://github.com/KhronosGroup/Vulkan-Loader
# https://github.com/KhronosGroup/Vulkan-Loader/blob/master/loader/LoaderAndLayerInterface.md

# Android Vulkan Loader
# https://android.googlesource.com/platform/frameworks/native/+/master/vulkan
# https://android.googlesource.com/platform/frameworks/native/+/master/vulkan/libvulkan/libvulkan.map.txt

clandro_step_get_source() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
		clandro_download_src_archive
		cd $CLANDRO_PKG_TMPDIR
		clandro_extract_src_archive
		mv "$CLANDRO_PKG_SRCDIR/android-ndk-r$CLANDRO_PKG_VERSION"/* "$CLANDRO_PKG_SRCDIR"
	else
		local lib_path="toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr"
		mkdir -p "$CLANDRO_PKG_SRCDIR"/"$lib_path"
		cp -fr "$NDK"/"$lib_path"/* "$CLANDRO_PKG_SRCDIR"/"$lib_path"/
	fi
}

clandro_step_host_build() {
	# Use NDK provided vulkan header version
	# instead of vulkan-loader-generic vulkan.pc
	# https://github.com/android/ndk/issues/1721
	cat <<- EOF > vulkan_header_version.c
	#include <stdio.h>
	#include "vulkan/vulkan_core.h"
	int main(void) {
		printf("%d.%d.%d\n",
			VK_HEADER_VERSION_COMPLETE >> 22,
			VK_HEADER_VERSION_COMPLETE >> 12 & 0x03ff,
			VK_HEADER_VERSION_COMPLETE & 0x0fff);
		return 0;
	}
	EOF
	rm -fr ./vulkan ./vk_video
	cp -fr "${CLANDRO_PKG_SRCDIR}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/vulkan" ./vulkan
	cp -fr "${CLANDRO_PKG_SRCDIR}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/vk_video" ./vk_video
	cc -I. vulkan_header_version.c -o vulkan_header_version
}

clandro_step_post_make_install() {
	install -v -Dm644 \
		"toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${CLANDRO_HOST_PLATFORM}/${CLANDRO_PKG_API_LEVEL}/libvulkan.so" \
		"${CLANDRO_PREFIX}/lib/libvulkan.so"

	local vulkan_loader_version
	vulkan_loader_version="$(${CLANDRO_PKG_HOSTBUILD_DIR}/vulkan_header_version)"
	if [[ -z "${vulkan_loader_version}" ]]; then
		clandro_error_exit "Host built vulkan_header_version is not printing version!"
	fi

	# https://github.com/KhronosGroup/Vulkan-Loader/blob/master/loader/vulkan.pc.in
	cat <<- EOF > "${CLANDRO_PKG_TMPDIR}/vulkan.pc"
	prefix=${CLANDRO_PREFIX}
	exec_prefix=\${prefix}
	libdir=\${exec_prefix}/lib
	includedir=\${prefix}/include
	Name: Vulkan-Loader
	Description: Vulkan Loader
	Version: ${vulkan_loader_version}
	Libs: -L\${libdir} -lvulkan
	Cflags: -I\${includedir}
	EOF
	install -Dm644 "${CLANDRO_PKG_TMPDIR}/vulkan.pc" "${CLANDRO_PREFIX}/lib/pkgconfig/vulkan.pc"
	echo "INFO: ========== vulkan.pc =========="
	cat "${CLANDRO_PREFIX}/lib/pkgconfig/vulkan.pc"
	echo "INFO: ========== vulkan.pc =========="

	ln -fsv libvulkan.so "${CLANDRO_PREFIX}/lib/libvulkan.so.1"
}

clandro_step_create_debscripts() {
	local system_lib="/system/lib"
	[[ "${CLANDRO_ARCH_BITS}" == "64" ]] && system_lib+="64"
	system_lib+="/libvulkan.so"
	local prefix_lib="${CLANDRO_PREFIX}/lib/libvulkan.so"

	cat <<- EOF > postinst
	#!${CLANDRO_PREFIX}/bin/sh
	if [ -e "${system_lib}" ]; then
	echo "Symlink ${system_lib} to ${prefix_lib} ..."
	ln -fsT "${system_lib}" "${prefix_lib}"
	fi
	EOF

	cat <<- EOF > postrm
	#!${CLANDRO_PREFIX}/bin/sh
	rm -f "${prefix_lib}"
	EOF
}
