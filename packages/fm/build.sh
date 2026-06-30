CLANDRO_PKG_HOMEPAGE=https://github.com/knipferrc/fm
CLANDRO_PKG_DESCRIPTION="A terminal based file manager"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.0"
CLANDRO_PKG_SRCURL=https://github.com/knipferrc/fm/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9ede202ab43aa810829a514695cd6b7e73fa81ee022b8f297eb66c23ce65c2ff
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin fm
}
