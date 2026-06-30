CLANDRO_PKG_HOMEPAGE=https://www.cipherdyne.org/fwknop/
CLANDRO_PKG_DESCRIPTION="fwknop: Single Packet Authorization > Port Knocking"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.6.11"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.cipherdyne.org/fwknop/download/fwknop-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=a4ec7c22dd90dd684f9f7b96d3a901c4131ec8c7a3b9db26d0428513f6774c64
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gpgme"
CLANDRO_PKG_BREAKS="fwknop-dev"
CLANDRO_PKG_REPLACES="fwknop-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-server
--with-gpgme
--with-gpg=$CLANDRO_PREFIX/bin/gpg2
"

clandro_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
