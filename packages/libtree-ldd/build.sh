CLANDRO_PKG_HOMEPAGE=https://github.com/haampie/libtree
CLANDRO_PKG_DESCRIPTION="Like ldd(1), but prints a tree(1) like output"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION=3.1.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/haampie/libtree/archive/refs/tags/v"$CLANDRO_PKG_VERSION".tar.gz
CLANDRO_PKG_SHA256=6148436f54296945d22420254dd78e1829d60124bb2f5b9881320a6550f73f5c
CLANDRO_PKG_DEPENDS="libandroid-glob"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CFLAGS+=" $CPPFLAGS"
}
