CLANDRO_PKG_HOMEPAGE=https://mupdf.com/
CLANDRO_PKG_DESCRIPTION="Lightweight PDF and XPS viewer (library)"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.24.10"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mupdf.com/downloads/archive/mupdf-${CLANDRO_PKG_VERSION}-source.tar.gz
CLANDRO_PKG_SHA256=939285b5f97caf770fd46cbe7e6cc3a695ab19bb5bfaf5712904549cef390b7b
CLANDRO_PKG_DEPENDS="freetype, gumbo-parser, harfbuzz, jbig2dec, leptonica, libc++, libjpeg-turbo, openjpeg, tesseract, zlib"
CLANDRO_PKG_EXTRA_MAKE_ARGS="prefix=$CLANDRO_PREFIX build=release libs shared=yes tesseract=yes V=1"
CLANDRO_PKG_BUILD_IN_SRC=true

# Automatic updates break k2pdfopt on regular basis
CLANDRO_PKG_AUTO_UPDATE=false

clandro_step_post_get_source() {
	mv pyproject.toml{,.unused}
	mv setup.py{,.unused}
	sed -i "s/HAVE_OBJCOPY := yes/HAVE_OBJCOPY := no/g" $CLANDRO_PKG_SRCDIR/Makerules
}

clandro_step_pre_configure() {
	rm -rf thirdparty/{freeglut,freetype,harfbuzz,jbig2dec,leptonica,libjpeg,openjpeg,tesseract,zlib}
	export USE_SYSTEM_LIBS=yes
	LDFLAGS+=" -llog"
}

clandro_step_post_make_install() {
	CLANDRO_PKG_EXTRA_MAKE_ARGS="${CLANDRO_PKG_EXTRA_MAKE_ARGS/shared=yes/}"
	clandro_step_make
	install -Dm600 -t $CLANDRO_PREFIX/lib build/release*/libmupdf{-third,}.a
	ln -sf $CLANDRO_PREFIX/lib/libmupdf.so.* $CLANDRO_PREFIX/lib/libmupdf.so
}
