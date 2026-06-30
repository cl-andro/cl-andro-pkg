CLANDRO_PKG_HOMEPAGE=https://github.com/OpenSC/libp11
CLANDRO_PKG_DESCRIPTION="PKCS#11 wrapper library"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.18"
CLANDRO_PKG_SRCURL=https://github.com/OpenSC/libp11/releases/download/libp11-${CLANDRO_PKG_VERSION}/libp11-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9292de67ca73aba1deacf577c9086b595765f36ef47712cfeb49fa31f6e772fb
CLANDRO_PKG_AUTO_UPDATE=true
# Make sure we strip off the entire `libp11-` prefix from the tag name.
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP='s/^libp11-//'
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
"
