CLANDRO_PKG_HOMEPAGE=https://talloc.samba.org/talloc/doc/html/index.html
CLANDRO_PKG_DESCRIPTION="Hierarchical, reference counted memory pool system with destructors"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.4.3
CLANDRO_PKG_SRCURL=https://www.samba.org/ftp/talloc/talloc-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dc46c40b9f46bb34dd97fe41f548b0e8b247b77a918576733c528e83abd854dd
CLANDRO_PKG_BREAKS="libtalloc-dev"
CLANDRO_PKG_REPLACES="libtalloc-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	# Force fresh install:
	rm -f $CLANDRO_PREFIX/include/talloc.h

	# Make sure symlinks are installed:
	rm $CLANDRO_PREFIX/lib/libtalloc* || true

	cd $CLANDRO_PKG_SRCDIR

	cat <<EOF > cross-answers.txt
Checking uname sysname type: "Linux"
Checking uname machine type: "dontcare"
Checking uname release type: "dontcare"
Checking uname version type: "dontcare"
Checking simple C program: OK
building library support: OK
Checking for large file support: OK
Checking for -D_FILE_OFFSET_BITS=64: OK
Checking for WORDS_BIGENDIAN: OK
Checking for C99 vsnprintf: OK
Checking for HAVE_SECURE_MKSTEMP: OK
rpath library support: OK
-Wl,--version-script support: FAIL
Checking correct behavior of strtoll: OK
Checking correct behavior of strptime: OK
Checking for HAVE_IFACE_GETIFADDRS: OK
Checking for HAVE_IFACE_IFCONF: OK
Checking for HAVE_IFACE_IFREQ: OK
Checking getconf LFS_CFLAGS: OK
Checking for large file support without additional flags: OK
Checking for working strptime: OK
Checking for HAVE_SHARED_MMAP: OK
Checking for HAVE_MREMAP: OK
Checking for HAVE_INCOHERENT_MMAP: OK
Checking getconf large file support flags work: OK
EOF

	./configure --prefix=$CLANDRO_PREFIX \
		--disable-rpath \
		--disable-python \
		--cross-compile \
		--cross-answers=cross-answers.txt
}

clandro_step_post_make_install() {
	cd $CLANDRO_PKG_SRCDIR/bin/default
	$AR rcu libtalloc.a talloc*.o
	install -Dm600 libtalloc.a $CLANDRO_PREFIX/lib/libtalloc.a
}
