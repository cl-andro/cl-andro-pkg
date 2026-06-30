CLANDRO_PKG_HOMEPAGE=https://github.com/wojtekka/6tunnel
CLANDRO_PKG_DESCRIPTION="Allows you to use services provided by IPv6 hosts with IPv4-only applications and vice-versa"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14"
CLANDRO_PKG_SRCURL=https://github.com/wojtekka/6tunnel/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f597edda55db4b6e661d7afdaa17c1f0c41aeadc21fc8b5599e678595906552b
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	autoreconf -fi
}
