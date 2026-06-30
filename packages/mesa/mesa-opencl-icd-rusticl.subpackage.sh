CLANDRO_SUBPKG_DESCRIPTION="Mesa's Rusticl OpenCL ICD"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_DEPENDS="clang (<< $CLANDRO_LLVM_NEXT_MAJOR_VERSION), libandroid-shmem, libc++, libclc, libdrm, libllvm (<< $CLANDRO_LLVM_NEXT_MAJOR_VERSION), zlib, zstd"
CLANDRO_SUBPKG_INCLUDE="
etc/OpenCL/vendors/rusticl.icd
lib/libRusticlOpenCL.so
lib/libRusticlOpenCL.so.1
"
