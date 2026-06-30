CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/motif/
CLANDRO_PKG_DESCRIPTION="Motif widget toolkit"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.8
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/motif/Motif%20${CLANDRO_PKG_VERSION}%20Source%20Code/motif-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=859b723666eeac7df018209d66045c9853b50b4218cecadb794e2359619ebce7
CLANDRO_PKG_DEPENDS="fontconfig, freetype, libandroid-support, libice, libiconv, libjpeg-turbo, libpng, libsm, libx11, libxext, libxft, libxmu, libxt"
CLANDRO_PKG_BUILD_DEPENDS="flex, xbitmaps, xorgproto"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file__usr_X_include_X11_X_h=no
ac_cv_file__usr_X11R6_include_X11_X_h=no
ac_cv_func_setpgrp_void=yes
"
CLANDRO_PKG_MAKE_PROCESSES=1
CLANDRO_PKG_HOSTBUILD=true

clandro_step_post_get_source() {
	rm -f tools/wml/{wmllex,wmluiltok}.c
}

clandro_step_host_build() {
	"$CLANDRO_PKG_SRCDIR/configure" ${CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}

	make -C config/util makestrs
	make -C lib/Xm
	make -C tools/wml wmluiltok LIBS=-lfl
	make -C tools/wml
}

clandro_step_pre_configure() {
	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR/config/util:$CLANDRO_PKG_HOSTBUILD_DIR/tools/wml:$PATH
}

clandro_step_post_configure() {
	make -C tools/wml wmluiltok LIBS=-lfl
}
