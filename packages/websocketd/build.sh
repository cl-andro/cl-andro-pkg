CLANDRO_PKG_HOMEPAGE=http://websocketd.com/
CLANDRO_PKG_DESCRIPTION="Turn any program that uses STDIN/STDOUT into a WebSocket server"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.1"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/joewalnes/websocketd/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6b8fe0fad586d794e002340ee597059b2cfc734ba7579933263aef4743138fe5
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build -o websocketd -ldflags "-X main.version=${CLANDRO_PKG_VERSION} -X main.buildinfo=$(date +%s)-@termux-${GOARCH}"
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin websocketd
}
