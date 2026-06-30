CLANDRO_PKG_HOMEPAGE=http://www.mutt.org/
CLANDRO_PKG_DESCRIPTION="Mail client with patches from neomutt"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.2"
CLANDRO_PKG_SRCURL=ftp://ftp.mutt.org/pub/mutt/mutt-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9b4f7a442e41c057774ba7c36fa41aba2edd2e7a12a86031e6ebb113bab2c79e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses, gdbm, openssl, libsasl, media-types, zlib, libiconv"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
mutt_cv_c99_snprintf=yes
mutt_cv_c99_vsnprintf=yes
--disable-gpgme
--enable-compressed
--enable-debug
--enable-hcache
--enable-imap
--enable-pop
--enable-sidebar
--enable-smtp
--with-exec-shell=$CLANDRO_PREFIX/bin/sh
--with-mailpath=$CLANDRO_PREFIX/var/mail
--without-idn
--with-sasl
--with-ssl
"

# fget{c,s}_unlocked were added in API level 28.
# AC_CHECK_FUNCS(fget{c,s}_unlocked) finds them in libc, even though
# it is not defined in stdio.h, so we need to override the check or
# else compilation on device fails
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
ac_cv_func_fgetc_unlocked=no
ac_cv_func_fgets_unlocked=no
"

if $CLANDRO_DEBUG_BUILD; then
	export CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="--enable-debug"
fi

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/flea
bin/muttbug
share/man/man1/muttbug.1
share/man/man1/flea.1
etc/mime.types.dist
"

CLANDRO_PKG_CONFFILES="etc/Muttrc"

clandro_step_pre_configure() {
	# Workaround -std=gnu23 in bundled configure script
	autoreconf -fiv
}

clandro_step_post_configure() {
	# Build wants to run mutt_md5:
	gcc -DHAVE_STDINT_H -DMD5UTIL $CLANDRO_PKG_SRCDIR/md5.c -o $CLANDRO_PKG_BUILDDIR/mutt_md5
	touch -d "next hour" $CLANDRO_PKG_BUILDDIR/mutt_md5
}

clandro_step_post_make_install() {
	cp doc/mutt.man $CLANDRO_PREFIX/share/man/man1/mutt.1.man
	mkdir -p $CLANDRO_PREFIX/share/examples/mutt/
	cp contrib/gpg.rc $CLANDRO_PREFIX/share/examples/mutt/
}
