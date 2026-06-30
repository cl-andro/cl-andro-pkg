CLANDRO_SUBPKG_DESCRIPTION="Mesa's Freedreno Vulkan ICD"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_DEPENDS="libandroid-shmem, libc++, libdrm, libx11, libxcb, libxshmfence, libwayland, vulkan-loader-generic, zlib, zstd"
CLANDRO_SUBPKG_EXCLUDED_ARCHES="i686, x86_64"
CLANDRO_SUBPKG_REPLACES="mesa-vulkan-icd-freedreno-dri3"
CLANDRO_SUBPKG_BREAKS="mesa-vulkan-icd-freedreno-dri3"
CLANDRO_SUBPKG_PROVIDES="mesa-vulkan-icd-freedreno-dri3"
CLANDRO_SUBPKG_INCLUDE="
lib/libvulkan_freedreno.so
share/vulkan/icd.d/freedreno_icd.*.json
"
