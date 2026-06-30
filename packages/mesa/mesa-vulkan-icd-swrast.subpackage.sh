CLANDRO_SUBPKG_DESCRIPTION="Mesa's Swrast Vulkan ICD"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_DEPENDS="libandroid-shmem, libc++, libdrm, libx11, libxcb, libxshmfence, libwayland, ncurses, vulkan-loader-generic, zlib, zstd"
CLANDRO_SUBPKG_INCLUDE="
lib/libvulkan_lvp.so
share/vulkan/icd.d/lvp_icd.*.json
"
