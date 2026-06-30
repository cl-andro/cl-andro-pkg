CLANDRO_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/wordexp.3.html
CLANDRO_PKG_DESCRIPTION="Shared library for the wordexp(3) system function"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	$CC $CFLAGS $CPPFLAGS -I$CLANDRO_PKG_BUILDER_DIR -c $CLANDRO_PKG_BUILDER_DIR/wordexp.c
	$CC $LDFLAGS -shared wordexp.o -o libandroid-wordexp.so
	$AR rcu libandroid-wordexp.a wordexp.o
}

clandro_step_make_install() {
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/wordexp.h $CLANDRO_PREFIX/include/wordexp.h
	install -Dm600 libandroid-wordexp.a $CLANDRO_PREFIX/lib/libandroid-wordexp.a
	install -Dm600 libandroid-wordexp.so $CLANDRO_PREFIX/lib/libandroid-wordexp.so
}
