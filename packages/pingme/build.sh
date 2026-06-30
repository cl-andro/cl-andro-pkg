CLANDRO_PKG_HOMEPAGE=https://github.com/kha7iq/pingme
CLANDRO_PKG_DESCRIPTION="A small utility which can be called from anywhere to send a message with particular information"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.7"
CLANDRO_PKG_SRCURL=https://github.com/kha7iq/pingme/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=054750be7085c5dfcaae2cea17119b39041beef4577dfdfaf8011804c0836e9d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin pingme
}
