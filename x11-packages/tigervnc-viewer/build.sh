CLANDRO_PKG_HOMEPAGE=https://tigervnc.org/
CLANDRO_PKG_DESCRIPTION="A viewer (client) for Virtual Network Computing"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.16.2"
CLANDRO_PKG_SRCURL="https://github.com/TigerVNC/tigervnc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=b107c0c8b8a962594281690366c24186e95c2ea4a169acbc0076aa62ed01f467
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fltk, libandroid-shmem, libc++, libgmp, libgnutls, libjpeg-turbo, libnettle, libpixman, libx11, libxext, libxi, libxrandr, libxrender, zlib"
CLANDRO_PKG_CONFLICTS="tigervnc (<< 1.9.0-4)"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SERVER=OFF
-DENABLE_NLS=OFF
-DFLTK_MATH_LIBRARY=
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem"
}
