CLANDRO_SUBPKG_DESCRIPTION="Block device identification library"
CLANDRO_SUBPKG_BREAKS="util-linux (<< 2.38.1-1)"
CLANDRO_SUBPKG_REPLACES="util-linux (<< 2.38.1-1)"
CLANDRO_SUBPKG_DEPENDS="libandroid-posix-semaphore"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_INCLUDE="
include/blkid/blkid.h
lib/libblkid.so
lib/pkgconfig/blkid.pc
share/man/man3/libblkid.3.gz
"
