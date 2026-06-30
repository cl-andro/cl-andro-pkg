CLANDRO_PKG_HOMEPAGE=https://github.com/xtaci/kcptun
CLANDRO_PKG_DESCRIPTION="A Stable & Secure Tunnel based on KCP with N:M multiplexing and FEC"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="20260101"
CLANDRO_PKG_SRCURL=https://github.com/xtaci/kcptun/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=814dcd0b1af47b8230b28139fda2187b3b1c2bf4c04b31648d72bc32daca299d
CLANDRO_PKG_REPLACES="kcptun-client, kcptun-server"
CLANDRO_PKG_BREAKS="kcptun-client, kcptun-server"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	LDFLAGS="-X main.VERSION=${CLANDRO_PKG_VERSION#*:} -s -w"
	GCFLAGS=""

	go build -mod=vendor -ldflags "$LDFLAGS" -gcflags "$GCFLAGS" -o kcptun-client github.com/xtaci/kcptun/client
	go build -mod=vendor -ldflags "$LDFLAGS" -gcflags "$GCFLAGS" -o kcptun-server github.com/xtaci/kcptun/server
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin kcptun-client
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin kcptun-server
}
