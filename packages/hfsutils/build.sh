CLANDRO_PKG_HOMEPAGE=https://www.mars.org/home/rob/proj/hfs/
CLANDRO_PKG_DESCRIPTION="Tool for manipulating HFS images"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.2.6
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=ftp://ftp.mars.org/pub/hfs/hfsutils-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bc9d22d6d252b920ec9cdf18e00b7655a6189b3f34f42e58d5bb152957289840
CLANDRO_PKG_DEPENDS="libandroid-support"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$CLANDRO_PREFIX/share/man"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_configure() {
	mkdir -p ${CLANDRO_PREFIX}/share/man/man1
}
