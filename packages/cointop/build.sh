CLANDRO_PKG_HOMEPAGE=https://cointop.sh/
CLANDRO_PKG_DESCRIPTION="A fast and lightweight interactive terminal based UI application for tracking cryptocurrencies"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.10
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/cointop-sh/cointop/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=18da0d25288deec7156ddd1d6923960968ab4adcdc917f85726b97d555d9b1b7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="build VERSION=${CLANDRO_PKG_VERSION#*:}"

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/cointop
}
