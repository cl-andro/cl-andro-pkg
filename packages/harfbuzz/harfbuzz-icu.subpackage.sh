CLANDRO_SUBPKG_INCLUDE="
include/harfbuzz/hb-icu.h
lib/libharfbuzz-icu*
lib/pkgconfig/harfbuzz-icu.pc
"
CLANDRO_SUBPKG_DESCRIPTION="OpenType text shaping engine ICU backend"
CLANDRO_SUBPKG_DEPENDS="libicu"
CLANDRO_SUBPKG_BREAKS="harfbuzz (<< 7.0.0)"
CLANDRO_SUBPKG_REPLACES="harfbuzz (<< 7.0.0)"
