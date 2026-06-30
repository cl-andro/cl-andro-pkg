CLANDRO_PKG_HOMEPAGE=https://p4gefau1t.github.io/trojan-go
CLANDRO_PKG_DESCRIPTION="A Trojan proxy written in Go. An unidentifiable mechanism that helps you bypass GFW"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.6"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/p4gefau1t/trojan-go/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=925f02647dda944813f1eab0b71eac98b83eb5964ef5a6f63e89bc7eb4486c1f
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy -compat=1.17
}

clandro_step_make() {
	go build -tags "full"
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin trojan-go
}
