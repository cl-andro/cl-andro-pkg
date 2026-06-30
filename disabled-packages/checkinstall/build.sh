# NOTE: Currently segfaults when running.
CLANDRO_PKG_HOMEPAGE=http://checkinstall.izto.org/
CLANDRO_PKG_DESCRIPTION="Installation tracker creating a package from a local install"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.2
CLANDRO_PKG_SRCURL=http://checkinstall.izto.org/files/source/checkinstall-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256="dc61192cf7b8286d42c44abae6cf594ee52eafc08bfad0bea9d434b73dd593f4"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="file, make"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/checkinstall/locale/"

clandro_step_pre_configure() {
	CFLAGS+=" -D__off64_t=off64_t"
	CFLAGS+=" -D_STAT_VER=3"
	CFLAGS+=" -D_MKNOD_VER=1"
	CFLAGS+=" -DS_IREAD=S_IRUSR"
}

clandro_step_post_make_install() {
	mv $CLANDRO_PREFIX/lib/checkinstall/checkinstallrc-dist \
	   $CLANDRO_PREFIX/lib/checkinstall/checkinstallrc
}
