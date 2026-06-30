CLANDRO_SUBPKG_DESCRIPTION="Library for building Telegram clients, used by Telegram Desktop"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_DEPENDS="libc++, readline, openssl (>= 1.1.1), zlib"
CLANDRO_SUBPKG_CONFLICTS="libtd, libtd-static"
CLANDRO_SUBPKG_INCLUDE="
include/td/*
lib/cmake/tde2e/*
lib/pkgconfig/td*.pc
lib/libtd*.a
"
