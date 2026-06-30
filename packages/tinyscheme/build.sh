CLANDRO_PKG_HOMEPAGE=https://tinyscheme.sourceforge.net/home.html
CLANDRO_PKG_DESCRIPTION="Very small scheme implementation"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.42
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=http://downloads.sourceforge.net/project/tinyscheme/tinyscheme/tinyscheme-${CLANDRO_PKG_VERSION}/tinyscheme-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=17b0b1bffd22f3d49d5833e22a120b339039d2cfda0b46d6fc51dd2f01b407ad
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	LD=$CC
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/tinyscheme/
	cp $CLANDRO_PKG_SRCDIR/init.scm $CLANDRO_PREFIX/share/tinyscheme/
}
