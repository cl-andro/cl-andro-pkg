CLANDRO_PKG_HOMEPAGE=https://yuma123.org/
CLANDRO_PKG_DESCRIPTION="Provides an opensource YANG API in C"
CLANDRO_PKG_LICENSE="BSD 3-Clause, MIT, Public Domain"
CLANDRO_PKG_LICENSE_FILE="debian/copyright"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.13
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/yuma123/yuma123_${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e304b253236a279f10b133fdd19f366f271581ebf12647cea84667fcfada1f0c
CLANDRO_PKG_DEPENDS="libssh2, libxml2, openssl, readline"

clandro_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -D__USE_BSD"
}
