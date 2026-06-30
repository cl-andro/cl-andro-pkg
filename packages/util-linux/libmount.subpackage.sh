CLANDRO_SUBPKG_DESCRIPTION="Library for (un)mounting filesystems"
CLANDRO_SUBPKG_DEPENDS="libblkid, libsmartcols"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_INCLUDE="
include/libmount/libmount.h
lib/libmount.so
lib/pkgconfig/mount.pc
"
