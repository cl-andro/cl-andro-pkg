CLANDRO_PKG_HOMEPAGE=https://www.tarsnap.com/scrypt.html
CLANDRO_PKG_DESCRIPTION="scrypt KDF library and file encryption tool"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.tarsnap.com/scrypt/scrypt-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=1c2710517e998eaac2e97db11f092e37139e69886b21a1b2661f64e130215ae9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl"

clandro_step_pre_configure() {
	sed -i '/# Detect specific ARM features/,$d' $CLANDRO_PKG_SRCDIR/libcperciva/cpusupport/Build/cpusupport.sh
}
