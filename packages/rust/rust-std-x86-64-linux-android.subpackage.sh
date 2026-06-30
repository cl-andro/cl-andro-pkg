CLANDRO_SUBPKG_DESCRIPTION="Rust std for target x86_64-linux-android"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_BREAKS="rust (<< 1.74.1-1)"
CLANDRO_SUBPKG_REPLACES="rust (<< 1.74.1-1)"
CLANDRO_SUBPKG_INCLUDE="
lib/rustlib/x86_64-linux-android/lib/*.rlib
lib/rustlib/x86_64-linux-android/lib/libstd-*.so
"
