CLANDRO_PKG_HOMEPAGE="https://www.cups.org/"
CLANDRO_PKG_DESCRIPTION="Common UNIX Printing System"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.19"
CLANDRO_PKG_SRCURL=https://github.com/OpenPrinting/cups/releases/download/v${CLANDRO_PKG_VERSION}/cups-${CLANDRO_PKG_VERSION}-source.tar.gz
CLANDRO_PKG_SHA256=820984b12a67f98705785aae2dd1347fe0ac097828001d4583ff64574aed6389
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libcrypt, libgnutls, libiconv, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-spawn"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-tls=gnutls
"
CLANDRO_PKG_EXTRA_MAKE_ARGS="
DBUSDIR=$PREFIX/etc/dbus-1
"
CLANDRO_PKG_CONFFILES="
etc/cups/cups-files.conf
etc/cups/cupsd.conf
etc/cups/snmp.conf
"

CLANDRO_PKG_SERVICE_SCRIPT=("cupsd" "mkdir -p $CLANDRO_PREFIX/var/run/cups && exec cupsd -f")

clandro_step_pre_configure() {
	export CHOWNPROG=true CHGRPPROG=true
}

clandro_step_post_massage() {
	# Restore world-readable permissions stripped by clandro_step_massage
	chmod -R o+rX share/doc/cups
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${CLANDRO_PREFIX}/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/run/cups
	mkdir -p $CLANDRO_PREFIX/var/spool/cups/tmp
	mkdir -p $CLANDRO_PREFIX/var/cache/cups
	EOF
}
