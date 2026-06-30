CLANDRO_PKG_HOMEPAGE=https://android.googlesource.com/platform/bionic/+/refs/heads/master/libc/bionic/sys_sem.cpp
CLANDRO_PKG_DESCRIPTION="A shared library providing System V semaphores"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	local f
	for f in LICENSE sys_sem.{c,h}; do
		cp $CLANDRO_PKG_BUILDER_DIR/${f} ./
	done
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"
	CFLAGS+=" -fPIC"
}

clandro_step_make() {
	$CC $CFLAGS $CPPFLAGS sys_sem.c -c
	$CC $CFLAGS sys_sem.o -shared $LDFLAGS -o libandroid-sysv-semaphore.so
	$AR cru libandroid-sysv-semaphore.a sys_sem.o
}

clandro_step_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/lib libandroid-sysv-semaphore.{a,so}
	install -Dm600 -T sys_sem.h $CLANDRO_PREFIX/include/sys/sem.h
}
