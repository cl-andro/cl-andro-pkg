CLANDRO_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man7/sem_overview.7.html
CLANDRO_PKG_DESCRIPTION="Shared library for the posix semaphore system function"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=false

clandro_step_make() {
	$CC $CFLAGS $CPPFLAGS -c $CLANDRO_PKG_BUILDER_DIR/semaphore.c
	$CC $LDFLAGS -shared semaphore.o -o libandroid-posix-semaphore.so
	$AR rcu libandroid-posix-semaphore.a semaphore.o
	cp -f $CLANDRO_PKG_BUILDER_DIR/LICENSE $CLANDRO_PKG_SRCDIR/
}

clandro_step_make_install() {
	install -Dm600 libandroid-posix-semaphore.a $CLANDRO_PREFIX/lib/libandroid-posix-semaphore.a
	install -Dm600 libandroid-posix-semaphore.so $CLANDRO_PREFIX/lib/libandroid-posix-semaphore.so
}
