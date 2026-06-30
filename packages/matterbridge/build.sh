CLANDRO_PKG_HOMEPAGE=https://github.com/42wim/matterbridge
CLANDRO_PKG_DESCRIPTION="A simple chat bridge"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.26.0"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/42wim/matterbridge/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=00e1bbfe3b32f2feccf9a7f13a6f12b1ce28a5eb04cc7b922b344e3493497425
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build -tags whatsappmulti
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin matterbridge
}
