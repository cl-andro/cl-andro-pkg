CLANDRO_PKG_HOMEPAGE=https://www.freshports.org/devel/libexecinfo
CLANDRO_PKG_DESCRIPTION="A quick-n-dirty BSD licensed clone of backtrace facility found in the GNU libc"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.1
CLANDRO_PKG_SRCURL=http://distcache.FreeBSD.org/ports-distfiles/libexecinfo-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=c9a21913e7fdac8ef6b33250b167aa1fc0a7b8a175145e26913a4c19d8a59b1f

# Apparently not working for these arches:
CLANDRO_PKG_EXCLUDED_ARCHES="i686, x86_64"

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/LICENSE ./
}

clandro_step_pre_configure() {
	CFLAGS+=" -fvisibility=hidden -fno-strict-aliasing"
	LDFLAGS+=" -lm"
}

clandro_step_make() {
	local objs="execinfo.o stacktraverse.o"
	local f
	for f in $objs; do
		$CC $CFLAGS $CPPFLAGS "$CLANDRO_PKG_SRCDIR/${f%.o}.c" -c
	done
	$CC $CFLAGS $objs -shared $LDFLAGS -o libexecinfo.so
	$AR cru libexecinfo.a $objs
}

clandro_step_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/lib libexecinfo.{a,so}
	install -Dm600 -t $CLANDRO_PREFIX/include $CLANDRO_PKG_SRCDIR/execinfo.h
}
