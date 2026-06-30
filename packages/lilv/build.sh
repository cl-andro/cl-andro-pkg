CLANDRO_PKG_HOMEPAGE=https://drobilla.net/software/lilv.html
CLANDRO_PKG_DESCRIPTION="A C library to make the use of LV2 plugins as simple as possible for applications"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.26.4"
CLANDRO_PKG_SRCURL=https://download.drobilla.net/lilv-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1c8b5fcb78718173e67d76e51ad423f5113a9ff68463f2566195ae46396089e3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libsndfile, libzix, lv2, serd, sord, sratom"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbindings_py=disabled
"
