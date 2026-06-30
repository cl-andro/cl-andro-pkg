CLANDRO_PKG_HOMEPAGE=https://www.willus.com/k2pdfopt/
CLANDRO_PKG_DESCRIPTION="A tool that optimizes PDF files for viewing on mobile readers"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.55"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://www.willus.com/k2pdfopt/src/k2pdfopt_v${CLANDRO_PKG_VERSION}_src.zip
CLANDRO_PKG_SHA256=3e78b4c7dd6227fde12138fd2468dd13c0c45b5251592a4f0aac67fd139ab953
CLANDRO_PKG_DEPENDS="djvulibre, gsl, leptonica, libjasper, libjpeg-turbo, libpng, mupdf, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -DHAVE_MUPDF_LIB=1"
	LDFLAGS+=" -lmupdf -L$CLANDRO_PREFIX/lib"
}
