CLANDRO_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/glob.3.html
CLANDRO_PKG_DESCRIPTION="Shared library for the glob(3) system function"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.6
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_BREAKS="libandroid-glob-dev"
CLANDRO_PKG_REPLACES="libandroid-glob-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=false

clandro_step_make() {
	$CC $CFLAGS $CPPFLAGS -I$CLANDRO_PKG_BUILDER_DIR -c $CLANDRO_PKG_BUILDER_DIR/glob.c
	$CC $LDFLAGS -shared glob.o -o libandroid-glob.so
	$AR rcu libandroid-glob.a glob.o
	cp -f $CLANDRO_PKG_BUILDER_DIR/LICENSE $CLANDRO_PKG_SRCDIR/
}

clandro_step_make_install() {
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/glob.h $CLANDRO_PREFIX/include/glob.h
	install -Dm600 libandroid-glob.a $CLANDRO_PREFIX/lib/libandroid-glob.a
	install -Dm600 libandroid-glob.so $CLANDRO_PREFIX/lib/libandroid-glob.so
}
