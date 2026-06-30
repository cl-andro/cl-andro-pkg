CLANDRO_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/backtrace.3.html
CLANDRO_PKG_DESCRIPTION="Shared library for the backtrace system function"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PROVIDES="libexecinfo"
CLANDRO_PKG_CONFLICTS="libexecinfo"

# Files are taken from the Bionic libc repo.
# exexinfo.h: https://android.googlesource.com/platform/bionic/+/refs/heads/master/libc/include/execinfo.h
# execinfo.c: https://android.googlesource.com/platform/bionic/+/refs/heads/master/libc/bionic/execinfo.cpp
clandro_step_make() {
	$CC $CFLAGS -I$CLANDRO_PKG_BUILDER_DIR -c $CLANDRO_PKG_BUILDER_DIR/execinfo.c
	$CC $LDFLAGS -shared execinfo.o -o libandroid-execinfo.so \
		-Wl,-soname=libandroid-execinfo.so
	$AR rcu libandroid-execinfo.a execinfo.o
	cp -f $CLANDRO_PKG_BUILDER_DIR/LICENSE $CLANDRO_PKG_SRCDIR/
}

clandro_step_make_install() {
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/execinfo.h $CLANDRO_PREFIX/include/execinfo.h
	install -Dm600 libandroid-execinfo.a $CLANDRO_PREFIX/lib/libandroid-execinfo.a
	install -Dm600 libandroid-execinfo.so $CLANDRO_PREFIX/lib/libandroid-execinfo.so
	ln -sfr $CLANDRO_PREFIX/lib/libandroid-execinfo.so $CLANDRO_PREFIX/lib/libexecinfo.so
}
