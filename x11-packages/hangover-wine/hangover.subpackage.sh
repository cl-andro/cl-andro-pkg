CLANDRO_SUBPKG_DESCRIPTION="Hangover runs simple Win64 and Win32 applications on arm64 Linux"
CLANDRO_SUBPKG_INCLUDE="
share/doc/hangover/copyright
"
CLANDRO_SUBPKG_DEPENDS="hangover-libwow64fex, hangover-libarm64ecfex, hangover-wowbox64"
# hangover : Depends: hangover-libwow64fex but it is not installable
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=false
