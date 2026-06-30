CLANDRO_PKG_HOMEPAGE=https://git.causal.agency/libretls/about/
CLANDRO_PKG_DESCRIPTION="libtls for OpenSSL"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.8.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://git.causal.agency/libretls/snapshot/libretls-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4a705c9c079dc70383ccc08432b93fbb61f9ec5873a92883e01e0940b8eaf3de
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_REPLACES="libtls"
CLANDRO_PKG_PROVIDES="libtls"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_install_license() {
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/LICENSE -t ${CLANDRO_PREFIX}/share/doc/${CLANDRO_PKG_NAME}
}
