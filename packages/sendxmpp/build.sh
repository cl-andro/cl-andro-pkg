CLANDRO_PKG_HOMEPAGE=https://sendxmpp.hostname.sk/
CLANDRO_PKG_DESCRIPTION="A perl-script to send XMPP (jabber) messages"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_VERSION=1.24
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/lhost/sendxmpp/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dfaf735b4585efd6b3b0f95db31203f9ab0fe607b50e75c6951bc18a6269837d
CLANDRO_PKG_DEPENDS="perl, clang, make"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin sendxmpp
}

clandro_step_create_debscripts()  {
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	set -e

	export PERL_MM_USE_DEFAULT=1

	echo "Sideloading Perl Authen::SASL and Net::XMPP ..."
	cpan -Ti Authen::SASL Net::XMPP

	exit 0
	POSTINST_EOF
}
