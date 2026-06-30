CLANDRO_PKG_HOMEPAGE=https://www.nlnetlabs.nl/projects/ldns/
CLANDRO_PKG_DESCRIPTION="Library for simplifying DNS programming and supporting recent and experimental RFCs"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.8.4
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.nlnetlabs.nl/downloads/ldns/ldns-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=838b907594baaff1cd767e95466a7745998ae64bc74be038dccc62e2de2e4247
CLANDRO_PKG_DEPENDS="openssl, resolv-conf"
CLANDRO_PKG_BREAKS="ldns-dev"
CLANDRO_PKG_REPLACES="ldns-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-ssl=$CLANDRO_PREFIX
--disable-gost
--with-drill
"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_make_install() {
	# The ldns build doesn't install its pkg-config:
	mkdir -p $CLANDRO_PREFIX/lib/pkgconfig
	cp packaging/libldns.pc $CLANDRO_PREFIX/lib/pkgconfig/libldns.pc
}
