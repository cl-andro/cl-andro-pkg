CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/inetutils/
CLANDRO_PKG_DESCRIPTION="Collection of common network programs"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7"
CLANDRO_PKG_SRCURL="https://mirrors.kernel.org/gnu/inetutils/inetutils-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=a156be1cde3c5c0ffefc262180d9369a60484087907aa554c62787d2f40ec086
CLANDRO_PKG_DEPENDS="readline"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-glob"
CLANDRO_PKG_SUGGESTS="whois"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_RM_AFTER_INSTALL="bin/whois share/man/man1/whois.1"
# These are old cruft / not suited for android
# (we --disable-traceroute as it requires root
# in favour of tracepath, which sets up traceroute
# as a symlink to tracepath):
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ifconfig
--disable-ping
--disable-ping6
--disable-rcp
--disable-rexec
--disable-rexecd
--disable-rlogin
--disable-rsh
--disable-traceroute
--disable-uucpd
ac_cv_lib_crypt_crypt=no
gl_cv_have_weak=no
"

clandro_step_host_build() {
	# help2man fails to get mans from our binaries
	# let's build binaries it can launch for generating mans

	cp -r "$CLANDRO_PKG_SRCDIR"/* .
	aclocal --force
	autoreconf -fi

	# For some reason I get undefined reference to `crypt` so I make it noop
	echo "__attribute__((weak)) void crypt(void) {}" | gcc -x c -c - -o crypt.o

	sed -i 's/PATH_LOG/"logcat"/g' ./src/logger.c
	LDFLAGS=" $CLANDRO_PKG_HOSTBUILD_DIR/crypt.o" \
	./configure $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	make
}

clandro_step_pre_configure() {
	aclocal --force
	autoreconf -fi

	# Reuse binaries from host-build to generate mans
	sed -i 's,@HOSTBUILD@,'"$CLANDRO_PKG_HOSTBUILD_DIR"',' "$CLANDRO_PKG_SRCDIR/man/Makefile.am"
	CFLAGS+=" -DNO_INLINE_GETPASS=1"
	CPPFLAGS+=" -DNO_INLINE_GETPASS=1 -DLOGIN_PROCESS=6 -DDEAD_PROCESS=8 -DLOG_NFACILITIES=24 -fcommon"
	LDFLAGS+=" -landroid-glob -llog"
	touch -d "next hour" ./man/whois.1
}

clandro_step_post_configure() {
	cp $CLANDRO_PKG_BUILDER_DIR/malloc.h $CLANDRO_PKG_BUILDDIR/lib/
}
