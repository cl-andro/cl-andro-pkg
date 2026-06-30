CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/libtasn1/
CLANDRO_PKG_DESCRIPTION="This is GNU Libtasn1, a small ASN.1 library"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.21.0"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/libtasn1/libtasn1-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1d8a444a223cc5464240777346e125de51d8e6abf0b8bac742ac84609167dc87
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	autoreconf -fi
}
