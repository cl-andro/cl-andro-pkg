CLANDRO_PKG_HOMEPAGE=https://github.com/fatedier/frp
CLANDRO_PKG_DESCRIPTION="A fast reverse proxy to expose a local server behind a NAT or firewall to the internet"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="2096779623 <admin@utermux.dev>"
CLANDRO_PKG_VERSION="0.68.1"
CLANDRO_PKG_SRCURL=https://github.com/fatedier/frp/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=44ed7107bf35e4f68dc0e77cd5805102effa5301528b89ee5ab0ab379088edc6
CLANDRO_PKG_REPLACES="frpc, frps"
CLANDRO_PKG_BREAKS="frpc, frps"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	(
		clandro_setup_nodejs
		unset CC CXX CFLAGS CXXFLAGS CPPFLAGS LDFLAGS AR AS CPP LD RANLIB READELF STRIP PREFIX PKGCONFIG PKG_CONFIG PKG_CONFIG_DIR PKG_CONFIG_LIBDIR
		pushd web/frpc
		npm install
		npm run build
		popd # web/frpc
		pushd web/frps
		npm install
		npm run build
		popd # web/frps
	)

	clandro_setup_golang
	make frpc
	make frps
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin bin/frpc
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin bin/frps
}
