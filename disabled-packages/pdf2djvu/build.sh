CLANDRO_PKG_HOMEPAGE=https://github.com/jwilk/pdf2djvu
CLANDRO_PKG_DESCRIPTION="PDF to DjVu converter"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.9.19
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://github.com/jwilk/pdf2djvu/releases/download/${CLANDRO_PKG_VERSION}/pdf2djvu-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=eb45a480131594079f7fe84df30e4a5d0686f7a8049dc7084eebe22acc37aa9a
CLANDRO_PKG_DEPENDS="djvulibre, libc++, libiconv, poppler"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-xmp
--disable-openmp
"

clandro_step_pre_configure() {
	CXXFLAGS+=" -std=c++20"
}
