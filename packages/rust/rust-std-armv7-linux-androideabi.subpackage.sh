CLANDRO_SUBPKG_DESCRIPTION="Rust std for target armv7-linux-androideabi"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_BREAKS="rust (<< 1.74.1-1)"
CLANDRO_SUBPKG_REPLACES="rust (<< 1.74.1-1)"
CLANDRO_SUBPKG_INCLUDE="
lib/rustlib/armv7-linux-androideabi/lib/*.rlib
lib/rustlib/armv7-linux-androideabi/lib/libstd-*.so
"
