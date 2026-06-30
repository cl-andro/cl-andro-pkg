CLANDRO_PKG_HOMEPAGE=https://movit.sesse.net/
CLANDRO_PKG_DESCRIPTION="The modern video toolkit"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_VERSION="1.7.2"
CLANDRO_PKG_SRCURL=https://movit.sesse.net/movit-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=00ac1f8e46c2d3e38c75cbb7a1af0a615751c158c611cb70053094b65ecfe8d5
CLANDRO_PKG_DEPENDS="fftw, libepoxy"
CLANDRO_PKG_BUILD_DEPENDS="eigen, googletest, sdl2"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-static"
CLANDRO_PKG_EXTRA_MAKE_ARGS="TESTS="

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/make_bundled_shaders.py $CLANDRO_PKG_SRCDIR/
	chmod +x $CLANDRO_PKG_SRCDIR/make_bundled_shaders.py
}

clandro_step_pre_configure() {
	# fix arm build and potentially other archs hidden bugs
	# ERROR: ./lib/libmovit.so contains undefined symbols:
	#     69: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __aeabi_uidiv
	#    120: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __aeabi_idiv
	#    155: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __aeabi_ul2d
	#    205: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __aeabi_uidivmod
	#    217: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __aeabi_idivmod
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
	autoreconf -fi
}
