CLANDRO_PKG_HOMEPAGE=https://github.com/pufferffish/wireproxy
CLANDRO_PKG_DESCRIPTION="Wireguard client that exposes itself as a socks5 proxy"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.2"
CLANDRO_PKG_SRCURL=https://github.com/pufferffish/wireproxy/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=c2568017c7e27c0642c27b68b9b1adb34e6fe8165277f75a48e47d6af6bcf3e4
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"

clandro_step_make() {
	clandro_setup_golang

	go build -trimpath -ldflags "-s -w -X 'main.version=${CLANDRO_PKG_VERSION}'" ./cmd/wireproxy
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin wireproxy
}
