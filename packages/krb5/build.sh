CLANDRO_PKG_HOMEPAGE=https://web.mit.edu/kerberos
CLANDRO_PKG_DESCRIPTION="The Kerberos network authentication system"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="../NOTICE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.22.2"
CLANDRO_PKG_SRCURL=https://kerberos.org/dist/krb5/$(grep -oP "^\d+\.\d+" <<< $CLANDRO_PKG_VERSION)/krb5-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=3243ffbc8ea4d4ac22ddc7dd2a1dc54c57874c40648b60ff97009763554eaf13
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libandroid-glob, libresolv-wrapper, readline, openssl, libdb"
CLANDRO_PKG_BREAKS="krb5-dev"
CLANDRO_PKG_REPLACES="krb5-dev"
CLANDRO_PKG_CONFFILES="etc/krb5.conf var/krb5kdc/kdc.conf"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-readline
--without-system-verto
--enable-dns-for-realm
--sbindir=$CLANDRO_PREFIX/bin
--with-size-optimizations
--with-system-db
DEFCCNAME=$CLANDRO_PREFIX/tmp/krb5cc_%{uid}
DEFKTNAME=$CLANDRO_PREFIX/etc/krb5.keytab
DEFCKTNAME=$CLANDRO_PREFIX/var/krb5/user/%{euid}/client.keytab
"

clandro_step_post_get_source() {
	CLANDRO_PKG_SRCDIR+="/src"
}

clandro_step_pre_configure() {
	# cannot test these when cross compiling
	export krb5_cv_attr_constructor_destructor='yes,yes'
	export ac_cv_func_regcomp='yes'
	export ac_cv_printf_positional='yes'

	# bionic doesn't have getpass
	cp "$CLANDRO_PKG_BUILDER_DIR/netbsd_getpass.c" "$CLANDRO_PKG_SRCDIR/clients/kpasswd/"

	CFLAGS="$CFLAGS -D_PASSWORD_LEN=PASS_MAX"
	export LIBS="-landroid-glob -lresolv_wrapper"
}

clandro_step_post_make_install() {
	# Enable logging to STDERR by default
	echo -e "\tdefault = STDERR" >> $CLANDRO_PKG_SRCDIR/config-files/krb5.conf

	# Sample KDC config file
	install -dm 700 $CLANDRO_PREFIX/var/krb5kdc
	install -pm 600 $CLANDRO_PKG_SRCDIR/config-files/kdc.conf $CLANDRO_PREFIX/var/krb5kdc/kdc.conf

	# Default configuration file
	install -pm 600 $CLANDRO_PKG_SRCDIR/config-files/krb5.conf $CLANDRO_PREFIX/etc/krb5.conf

	install -dm 700 $CLANDRO_PREFIX/share/aclocal
	install -m 600 $CLANDRO_PKG_SRCDIR/util/ac_check_krb5.m4 $CLANDRO_PREFIX/share/aclocal
}
