# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://www.chiark.greenend.org.uk/ucgi/~ian/git/authbind.git
CLANDRO_PKG_DESCRIPTION="Bind sockets to privileged ports without root"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.2.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/a/authbind/authbind_${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8d265ee08e66fbda2e6c2b348624cd4552ff2c8fe72247d8904b06500c476adf
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_MAKE_INSTALL_TARGET="install install_man"

clandro_step_pre_configure() {
	sed -i 's|/\.$|/|g' Makefile
}

clandro_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$CLANDRO_PREFIX/bin/sh
		mkdir -p $CLANDRO_PREFIX/etc/authbind/byaddr
		mkdir -p $CLANDRO_PREFIX/etc/authbind/byport
		mkdir -p $CLANDRO_PREFIX/etc/authbind/byuid
		echo
		echo "********"
		echo "Remember to setuid root the helper program"
		echo
		echo "    $CLANDRO_PREFIX/libexec/authbind/helper"
		echo "********"
		echo
	EOF
}
