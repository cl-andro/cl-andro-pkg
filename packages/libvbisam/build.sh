CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/vbisam/
CLANDRO_PKG_DESCRIPTION="A replacement for IBM's C-ISAM"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/vbisam/vbisam2/vbisam-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=688b776e0030cce50fd7e44cbe40398ea93431f76510c7100433cc6313eabc4f

clandro_step_pre_configure() {
	CFLAGS+=" -Wno-implicit-int"
	cp $CLANDRO_PKG_BUILDER_DIR/efgcvt_r-template.c $CLANDRO_PKG_SRCDIR/libvbisam/
	cp $CLANDRO_PKG_BUILDER_DIR/efgcvt-dbl-macros.h $CLANDRO_PKG_SRCDIR/libvbisam/
	autoreconf -fi
}
