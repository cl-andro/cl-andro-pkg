CLANDRO_PKG_HOMEPAGE=https://github.com/showwin/speedtest-go/
CLANDRO_PKG_DESCRIPTION="Command line interface to test internet speed using speedtest.net"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.10"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/showwin/speedtest-go/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=70a2937d0759820fe7ee8f61b960d60c07b34c0d783ed11c0065b68fe2964aea
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
	install -Dm700 -t $CLANDRO_PREFIX/bin speedtest-go
}
