CLANDRO_PKG_HOMEPAGE=https://geth.ethereum.org/
CLANDRO_PKG_DESCRIPTION="Go implementation of the Ethereum protocol"
CLANDRO_PKG_LICENSE="LGPL-3.0, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.17.2"
CLANDRO_PKG_SRCURL=https://github.com/ethereum/go-ethereum/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cdbfcf0eb282849d0ffce21e1cffd82b51a1d08c27421d7fa86dccf65b76b523
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SUGGESTS="geth-utils"

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "${GOPATH}"/src/github.com/ethereum
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/ethereum/go-ethereum

	cd "$GOPATH"/src/github.com/ethereum/go-ethereum
	for applet in abidump abigen blsync clef devp2p era ethkey evm geth rlpdump; do
		go -C ./cmd/"$applet" build -v
	done
	unset applet
}

clandro_step_make_install() {
	for applet in abidump abigen blsync clef devp2p era ethkey evm geth rlpdump; do
		install -Dm700 \
			"$CLANDRO_PKG_SRCDIR/cmd/$applet/$applet" \
			"$CLANDRO_PREFIX"/bin/
	done
	unset applet
}
