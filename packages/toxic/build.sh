CLANDRO_PKG_HOMEPAGE=https://github.com/JFreegman/toxic
CLANDRO_PKG_DESCRIPTION="A command line client for Tox"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.16.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/JFreegman/toxic/archive/refs/tags/v${CLANDRO_PKG_VERSION}/toxic-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6b74c82c286f9ab3a8c8a5b4bf506ab5a4aca12620792a5273988bb795ea46ad
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="c-toxcore, libconfig, libcurl, libpng, libqrencode, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	make \
		PREFIX="${CLANDRO_PREFIX}" \
		CC="${CC}" \
		PKG_CONFIG="${PKG_CONFIG}" \
		USER_CFLAGS="${CFLAGS}" \
		USER_LDFLAGS="${LDFLAGS}"
}

clandro_step_make_install() {
	make PREFIX="${CLANDRO_PREFIX}" install
}
