CLANDRO_PKG_HOMEPAGE=https://xmlstar.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Command line XML toolkit"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.1
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=http://downloads.sourceforge.net/project/xmlstar/xmlstarlet/${CLANDRO_PKG_VERSION}/xmlstarlet-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=15d838c4f3375332fd95554619179b69e4ec91418a3a5296e7c631b7ed19e7ca
CLANDRO_PKG_DEPENDS="libxslt, libxml2"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-libxml-include-prefix=${CLANDRO_PREFIX}/include/libxml2"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_make_install() {
	ln -sfr $CLANDRO_PREFIX/bin/xml $CLANDRO_PREFIX/bin/xmlstarlet
}
