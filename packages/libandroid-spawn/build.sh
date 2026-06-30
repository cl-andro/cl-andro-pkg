CLANDRO_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/posix_spawn.3.html
CLANDRO_PKG_DESCRIPTION="Shared library for the posix_spawn system function"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.3
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	$CXX $CFLAGS $CPPFLAGS -I$CLANDRO_PKG_BUILDER_DIR -c $CLANDRO_PKG_BUILDER_DIR/posix_spawn.cpp
	$CXX $LDFLAGS -shared posix_spawn.o -o libandroid-spawn.so
	$AR rcu libandroid-spawn.a posix_spawn.o
	cp -f $CLANDRO_PKG_BUILDER_DIR/LICENSE $CLANDRO_PKG_SRCDIR/
}

clandro_step_make_install() {
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/posix_spawn.h $CLANDRO_PREFIX/include/spawn.h
	install -Dm600 libandroid-spawn.a $CLANDRO_PREFIX/lib/libandroid-spawn.a
	install -Dm600 libandroid-spawn.so $CLANDRO_PREFIX/lib/libandroid-spawn.so
}
