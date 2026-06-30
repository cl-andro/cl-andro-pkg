CLANDRO_PKG_HOMEPAGE=http://www.leonerd.org.uk/code/libtermkey/
CLANDRO_PKG_DESCRIPTION="Library for processing of keyboard entry for terminal-based programs"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.22
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=http://www.leonerd.org.uk/code/libtermkey/libtermkey-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6945bd3c4aaa83da83d80a045c5563da4edd7d0374c62c0d35aec09eb3014600
CLANDRO_PKG_DEPENDS="libunibilium"
CLANDRO_PKG_BREAKS="libtermkey-dev"
CLANDRO_PKG_REPLACES="libtermkey-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" -std=c99 -DHAVE_UNIBILIUM=1"
}

clandro_step_make() {
	$CC $CFLAGS $CPPFLAGS -c -fPIC termkey.c -o termkey.o
	$CC $CFLAGS $CPPFLAGS -c -fPIC driver-csi.c -o driver-csi.o
	$CC $CFLAGS $CPPFLAGS -c -fPIC driver-ti.c -o driver-ti.o

	$CC -shared -fPIC $LDFLAGS -o libtermkey.so \
		termkey.o driver-csi.o driver-ti.o -lunibilium
}

clandro_step_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/lib libtermkey.so
	chmod u+w termkey.h
	install -Dm600 termkey.h $CLANDRO_PREFIX/include/
	mkdir -p "$CLANDRO_PREFIX/share/pkgconfig"
	LIBDIR=$CLANDRO_PREFIX/lib INCDIR=$CLANDRO_PREFIX/include VERSION=$CLANDRO_PKG_VERSION sh termkey.pc.sh > \
			"$CLANDRO_PREFIX/share/pkgconfig/termkey.pc"
}
