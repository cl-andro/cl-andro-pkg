CLANDRO_PKG_HOMEPAGE="https://github.com/rest-sh/restish"
CLANDRO_PKG_DESCRIPTION="A CLI for interacting with REST-ish HTTP APIs"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE.md"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.21.2"
CLANDRO_PKG_SRCURL="https://github.com/rest-sh/restish/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=3686e652193c976a04c96f83ee1a78571509e22169b83f7212a7380b374d24b1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	go mod init || :
	go mod tidy

	go build
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}/bin" restish
}
