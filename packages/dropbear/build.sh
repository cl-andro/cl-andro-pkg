CLANDRO_PKG_HOMEPAGE=https://matt.ucc.asn.au/dropbear/dropbear.html
CLANDRO_PKG_DESCRIPTION="Small SSH server and client"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2025.89"
CLANDRO_PKG_SRCURL=https://matt.ucc.asn.au/dropbear/releases/dropbear-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=0d1f7ca711cfc336dc8a85e672cab9cfd8223a02fe2da0a4a7aeb58c9e113634
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="clandro-auth, zlib"
CLANDRO_PKG_SUGGESTS="openssh-sftp-server"
CLANDRO_PKG_CONFLICTS="openssh"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-syslog --disable-utmp --disable-utmpx --disable-wtmp --disable-static"
# Avoid linking to libcrypt for server password authentication:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"
# BIonic is special case, as usuas.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_htole64=yes"
# setresgid() is blocked by Android for non-root users, so disable it
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_setresgid=no"
# build a multi-call binary & enable progress info in 'scp'
CLANDRO_PKG_EXTRA_MAKE_ARGS="MULTI=1 SCPPROGRESS=1"

clandro_step_pre_configure() {
	export LIBS="-lclandro-auth -llog"
}

clandro_step_post_make_install() {
	ln -sf "dropbearmulti" "${CLANDRO_PREFIX}/bin/ssh"
}

clandro_step_create_debscripts() {
	{
	echo "#!$CLANDRO_PREFIX/bin/sh"
	echo "mkdir -p $CLANDRO_PREFIX/etc/dropbear"
	echo "for a in rsa ecdsa ed25519; do"
	echo "	KEYFILE=$CLANDRO_PREFIX/etc/dropbear/dropbear_\${a}_host_key"
	echo "	test ! -f \$KEYFILE && dropbearkey -t \$a -f \$KEYFILE"
	echo "done"
	echo "exit 0"
	} > postinst
	chmod 0755 postinst
}
