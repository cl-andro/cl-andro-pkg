CLANDRO_PKG_HOMEPAGE=https://android.googlesource.com/platform/ndk/
CLANDRO_PKG_DESCRIPTION="Thread debugging library"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=22 # removed in NDK r23
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://android.googlesource.com/platform/ndk/+archive/refs/tags/ndk-r${CLANDRO_PKG_VERSION}/sources/android/libthread_db.tar.gz
CLANDRO_PKG_SHA256=SKIP_CHECKSUM
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL}")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar xf "$file" -C "$CLANDRO_PKG_SRCDIR" libthread_db.c thread_db.h
}

clandro_step_post_get_source() {
	sha256sum -c $CLANDRO_PKG_BUILDER_DIR/src.sha256sum
	cp $CLANDRO_PKG_BUILDER_DIR/td_init.c ./
}

clandro_step_make() {
	$CC $CPPFLAGS -I. $CFLAGS libthread_db.c td_init.c \
		-shared -o libthread_db.so $LDFLAGS
}

clandro_step_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/include "$CLANDRO_PKG_SRCDIR/thread_db.h"
	install -Dm600 -t $CLANDRO_PREFIX/lib "$CLANDRO_PKG_BUILDDIR/libthread_db.so"
	ln -sf libthread_db.so $CLANDRO_PREFIX/lib/libthread_db.so.1
}
