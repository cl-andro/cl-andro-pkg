CLANDRO_PKG_HOMEPAGE=https://www.dovecot.org
CLANDRO_PKG_DESCRIPTION="Secure IMAP and POP3 email server"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.2.31
CLANDRO_PKG_SRCURL=https://www.dovecot.org/releases/2.2/dovecot-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=034be40907748128d65088a4f59789b2f99ae7b33a88974eae0b6a68ece376a1
CLANDRO_PKG_DEPENDS="openssl, libcrypt"
# turning on icu gives undefined reference to __cxa_call_unexpected
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-zlib
--with-ssl=openssl
--with-ssldir=$CLANDRO_PREFIX/etc/tls
--without-icu
--without-shadow
i_cv_epoll_works=yes
i_cv_posix_fallocate_works=yes
i_cv_signed_size_t=no
i_cv_gmtime_max_time_t=40
i_cv_signed_time_t=yes
i_cv_mmap_plays_with_write=yes
i_cv_fd_passing=yes
i_cv_c99_vsnprintf=yes
lib_cv_va_copy=yes
lib_cv___va_copy=yes
"

clandro_step_pre_configure() {
	LDFLAGS="$LDFLAGS -llog"

	for i in $(find $CLANDRO_PKG_SRCDIR/src/director -type f); do sed 's|\bstruct user\b|struct usertest|g' -i $i; done

	if [ "$CLANDRO_ARCH" == "aarch64" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=yes"
	else
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=no"
	fi
}

clandro_step_post_make_install() {
	for binary in doveadm doveconf; do
		mv $CLANDRO_PREFIX/bin/$binary $CLANDRO_PREFIX/libexec/dovecot/$binary
		cat > $CLANDRO_PREFIX/bin/$binary <<HERE
#!$CLANDRO_PREFIX/bin/sh
export LD_LIBRARY_PATH=$CLANDRO_PREFIX/lib/dovecot:\$LD_LIBRARY_PATH
exec $CLANDRO_PREFIX/libexec/dovecot/$binary $@
HERE
		chmod u+x $CLANDRO_PREFIX/bin/$binary
	done
}
