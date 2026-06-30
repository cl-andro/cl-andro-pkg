CLANDRO_PKG_HOMEPAGE=https://netpbm.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Toolkit for manipulation of graphic images of different formats"
CLANDRO_PKG_LICENSE="non-free"
CLANDRO_PKG_LICENSE_FILE="doc/copyright_summary"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:10.73.43
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/netpbm/super_stable/${CLANDRO_PKG_VERSION:2}/netpbm-${CLANDRO_PKG_VERSION:2}.tgz
CLANDRO_PKG_SHA256=f9fd9a7f932258224d1925bfce61396a15e0fad93e3853d6324ac308d1adebf8
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libjpeg-turbo, libpng, libtiff, libx11, libxml2"
CLANDRO_PKG_BREAKS="netpbm-dev"
CLANDRO_PKG_REPLACES="netpbm-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	# Put the android libpng-config script in the path (before the host one):
	CLANDRO_PKG_LIBPNG_CONFIG_DIR=$CLANDRO_PKG_TMPDIR/libpng-config
	mkdir -p $CLANDRO_PKG_LIBPNG_CONFIG_DIR
	cp $CLANDRO_PREFIX/bin/libpng-config $CLANDRO_PKG_LIBPNG_CONFIG_DIR/
	export PATH=$CLANDRO_PKG_LIBPNG_CONFIG_DIR:$PATH

	# See $SRC/doc/INSTALL about netpbm build system. For automatic builds it recommends just copying config.mk.in
	cd $CLANDRO_PKG_SRCDIR
	cp config.mk.in config.mk
	echo "AR = $AR" >> config.mk
	echo "RANLIB = $RANLIB" >> config.mk
	echo "CC = $CC" >> config.mk
	echo "CFLAGS = $CFLAGS" >> config.mk
	echo "CFLAGS_SHLIB = -fPIC" >> config.mk
	echo "LDFLAGS = $LDFLAGS" >> config.mk
	echo "STATICLIB_TOO = n" >> config.mk
	echo "INTTYPES_H = <inttypes.h>" >> config.mk
	export STRIPPROG=$STRIP

	echo "CC_FOR_BUILD = cc" >> config.mk
	echo "LD_FOR_BUILD = cc" >> config.mk
	echo "CFLAGS_FOR_BUILD = " >> config.mk
	echo "LDFLAGS_FOR_BUILD = " >> config.mk
	echo "JPEGLIB = ${CLANDRO_PREFIX}/lib/libjpeg.so" >> config.mk
	echo "TIFFLIB = ${CLANDRO_PREFIX}/lib/libtiff.so" >> config.mk
	echo "TIFFLIB_NEEDS_Z = N" >> config.mk

	cp $CLANDRO_PKG_BUILDER_DIR/standardppmdfont.c lib/
}

clandro_step_make_install() {
	rm -Rf /tmp/netpbm
	make -j 1 package pkgdir=/tmp/netpbm
	./installnetpbm
}
