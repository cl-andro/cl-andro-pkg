CLANDRO_PKG_HOMEPAGE=https://libcoap.net/
CLANDRO_PKG_DESCRIPTION="Implementation of CoAP, a lightweight protocol for resource constrained devices"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYING, LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.3.5b"
CLANDRO_PKG_SRCURL=https://github.com/obgm/libcoap/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=383a17d8466cee7c1cb1d4dfbffad2651004850b29eb590e9591c7bedd46741d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BREAKS="libcoap-dev"
CLANDRO_PKG_REPLACES="libcoap-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-openssl --disable-doxygen"

clandro_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}
