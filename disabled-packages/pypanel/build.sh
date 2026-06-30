# x11-packages
CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/pypanel/
CLANDRO_PKG_DESCRIPTION="A lightweight panel/taskbar for X11 window managers written in python."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.4
CLANDRO_PKG_REVISION=35
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/pypanel/PyPanel-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4e612b43c61b3a8af7d57a0364f6cd89df481dc41e20728afa643e9e3546e911
CLANDRO_PKG_DEPENDS="freetype, imlib2, libx11, libxft, python2, python2-xlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES="etc/pypanelrc"

clandro_step_make() {
	"${CC}" -DNDEBUG \
			-fwrapv \
			-Wall \
			-Wstrict-prototypes \
			-fno-strict-aliasing \
			-Oz \
			-fPIC \
			-DHAVE_XFT=1 \
			-DIMLIB2_FIX=1 \
			-I$CLANDRO_PREFIX/include \
			-I$CLANDRO_PREFIX/include/freetype2 \
			-I$CLANDRO_PREFIX/include/libpng16 \
			-c ppmodule.c \
			-o ppmodule.o \

	"${CC}" -shared \
			ppmodule.o \
			$LDFLAGS \
			-lfreetype \
			-lXft \
			-lImlib2 \
			-lpython2.7 \
			-lX11 \
			-o ppmodule.so
}

clandro_step_make_install() {
	mkdir -p "${CLANDRO_PREFIX}/bin"
	cp -f pypanel "${CLANDRO_PREFIX}/bin/pypanel"
	chmod 755 "${CLANDRO_PREFIX}/bin/pypanel"

	mkdir -p "${CLANDRO_PREFIX}/etc"
	cp -f pypanelrc "${CLANDRO_PREFIX}/etc/pypanelrc"
	chmod 644 "${CLANDRO_PREFIX}/etc/pypanelrc"

	mkdir -p "${CLANDRO_PREFIX}/lib/python2.7/site-packages"
	cp ppmodule.so "${CLANDRO_PREFIX}/lib/python2.7/site-packages/ppmodule.so"
	chmod 644 "${CLANDRO_PREFIX}/lib/python2.7/site-packages/ppmodule.so"

	mkdir -p "${CLANDRO_PREFIX}/lib/python2.7/site-packages/pypanel"
	cp -f COPYING README pypanelrc ppicon.png "${CLANDRO_PREFIX}/lib/python2.7/site-packages/pypanel/"
	chmod 644 ${CLANDRO_PREFIX}/lib/python2.7/site-packages/pypanel/*
}
