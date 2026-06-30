CLANDRO_PKG_HOMEPAGE=https://openvpn.net
CLANDRO_PKG_DESCRIPTION="An easy-to-use, robust, and highly configurable VPN (Virtual Private Network)"
# License: GPL-2.0-with-OpenSSL-exception
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7.4"
CLANDRO_PKG_SRCURL=https://github.com/OpenVPN/openvpn/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2235b8479b4fca0c43a8cd6a767858ab5b1e14cb4170e6211aa94549ed5d419e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcap-ng, liblz4, liblzo, net-tools, openssl"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-plugin-auth-pam
--disable-systemd
--disable-debug
--enable-iproute2
--enable-small
--enable-x509-alt-username
ac_cv_func_getpwnam=yes
IFCONFIG=$CLANDRO_PREFIX/bin/ifconfig
ROUTE=$CLANDRO_PREFIX/bin/route
IPROUTE=$CLANDRO_PREFIX/bin/ip
NETSTAT=$CLANDRO_PREFIX/bin/netstat
"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_make_install() {
	# Examples.
	install -d -m700 "$CLANDRO_PREFIX/share/openvpn/examples"
	cp "$CLANDRO_PKG_SRCDIR"/sample/sample-config-files/* "$CLANDRO_PREFIX/share/openvpn/examples"
}
