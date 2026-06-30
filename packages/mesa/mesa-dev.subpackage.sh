CLANDRO_SUBPKG_DESCRIPTION="Mesa's OpenGL headers"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_DEPENDS="libglvnd-dev"
CLANDRO_SUBPKG_BREAKS="mesa (<< 22.3.3-2), ndk-sysroot (<< 25b-3)"
CLANDRO_SUBPKG_REPLACES="mesa (<< 22.3.3-2), ndk-sysroot (<< 25b-3)"
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=true
CLANDRO_SUBPKG_INCLUDE="
include/GL/!(osmesa.h)
include/EGL/
include/gbm.h
"
